local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function create_not_in_comment_or_string_condition()
	return function(line_to_cursor, matched_trigger, captures)
		local _, current_row, current_col_byte, _, _ = unpack(vim.fn.getcurpos())
		current_row = current_row - 1
		local trigger_start_col_byte = current_col_byte - #matched_trigger
		if trigger_start_col_byte < 0 then
			trigger_start_col_byte = 0
		end
		local node = vim.treesitter.get_node({
			pos = { current_row, trigger_start_col_byte },
		})
		if not node then
			return true
		end
		while node do
			local node_type = node:type()
			if node_type:match("comment") then
				return false -- Inside a comment
			end
			if
				node_type:match("string")
				or node_type:match("interpolated_string")
				or node_type:match("string_literal")
				or node_type:match("quoted_string")
			then
				return false -- Inside a string
			end
			node = node:parent()
		end
		return true -- Not inside a comment or string
	end
end

ls.add_snippets("rust", {}, { key = "rust_manual_snippets" }) -- Good practice to add a key for reloading

-- Add AUTO snippets with the 'r' prefix
ls.add_snippets("rust", {

	-- 1. allow
	s(
		"allow",
		fmta(
			"#![allow(<1>)]", -- Use <1> to reference the first argument, which will be our choice node
			{
				c(1, { -- Choice node at tab stop 1
					t("unused_variables"), -- Option 1
					t("dead_code"), -- Option 2
					t("clippy::all"), -- Option 3
					i(nil, "your_custom_lint"), -- Option 4: A custom insert node with default text.
					-- The 'nil' as the tab stop is crucial for nodes directly within a choice node.
				}),
			}
		),
		{}
	),

	-- 2. deny
	s(
		"deny",
		fmta("#![deny(<1>)]", {
			c(1, {
				t("warnings"),
				t("unconditional_panic"),
				i(nil, "your_custom_lint"),
			}),
		}),
		{}
	),

	-- 3. warn
	s(
		"warn",
		fmta("#![warn(<1>)]", {
			c(1, {
				t("unused_imports"),
				t("unreachable_code"),
				i(nil, "your_custom_lint"),
			}),
		}),
		{}
	),

	-- 4. let
	s(
		"let",
		fmta("let <1> = <2>;", {
			i(1, "var"),
			i(2, "equal"),
		}),
		{}
	),

	-- 5. cfg
	s(
		"cfg",
		fmta("#[cfg(<1>)]", {
			c(1, { -- Choice node for common cfg attributes
				t("test"),
				t("debug_assertions"),
				t('target_os = "linux"'),
				t('feature = "my_feature"'),
				i(nil, ""), -- Empty insert node: LSP suggestions trigger here
			}),
		}),
		{}
	),

	-- 6. format_bang
	s(
		"format", -- Renamed from `rformat` to `rformat_bang` for uniqueness
		fmta('format!("<1>")', { i(1, "Hello, {}!") }),
		{}
	),

	-- 7. panic
	s("panic", fmta('panic!("<1>");', { i(1, "Error message: {}") }), {}),

	-- 8. println
	s("print", fmta('println!("<1>");', { i(1, "Hello, world!") }), {}),

	-- 9. vec_bang
	s("vec", fmta("vec![<1>]", { i(1, "elem1, elem2") }), {}),

	-- 10. assert_bang
	s("assert", fmta("assert!(<1>);", { i(1, "condition") }), {}),

	-- 11. assert_eq_bang
	s("eqassert", fmta("assert_eq!(<1>, <2>);", { i(1, "expected"), i(2, "actual") }), {}),

	-- 12. const
	s(
		"const",
		fmta([[const <1>: <2> = <3>;]], {
			i(1, "CONST_NAME"),
			i(2, "Type"),
			i(3, "init_value"),
		}),
		{}
	),

	-- 13. derive
	s(
		"derive",
		fmta("#[derive(<1>)]", {
			c(1, { -- Common derives
				t("Debug"),
				t("Clone, Copy"),
				t("PartialEq, Eq"),
				t("Default"),
				t("Hash"),
				i(nil, "Trait"), -- Custom derive
			}),
		}),
		{}
	),

	-- 14. enum
	s(
		"enum",
		fmta(
			[[
	            #[derive(Debug)]
	            enum <1> {
	                <2>,
	                <3>,
	            }
	            ]],
			{
				i(1, "Name"),
				i(2, "Variant1"),
				i(3, "Variant2"),
			}
		),
		{}
	),

	-- 15. Public Return Function
	s(
		"prnf",
		fmta(
			[[
	            pub fn <1>(<2>: <3>) ->> <4> {
	                <5>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "RetType"),
				i(5, "todo!();"), -- Default implementation placeholder
			}
		),
		{}
	),

	-- 16. Function
	s(
		"fn",
		fmta(
			[[
	            fn <1>(<2>: <3>) {
	                <4>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "todo!();"),
			}
		),
		{}
	),

	-- 17. Return Function
	s(
		"rnf",
		fmta(
			[[
	            fn <1>(<2>: <3>) ->> <4> {
	                <5>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "RetType"),
				i(5, "todo!();"),
			}
		),
		{}
	),

	-- 18. for
	s(
		"for",
		fmta(
			[[
	            for <1> in <2> {
	                <3>
	            }
	            ]],
			{
				i(1, "pat"),
				i(2, "expr"),
				i(3, "todo!();"),
			}
		),
		{}
	),

	-- 19. rif_let
	s(
		"lif",
		fmta(
			[[
	            if let <1> = <2> {
	                <0>
	            }
	            ]],
			{
				i(1, "Some(value)"),
				i(2, "expression"),
				[0] = i(0, "todo!();"), -- Corrected `[0] =` for i(0)
			}
		),
		{}
	),

	-- 20. if
	s(
		"if",
		fmta(
			[[
	            if <1> {
	                <2>
	            }
	            ]],
			{
				i(1, "condition"),
				i(2, "todo!();"),
			}
		),
		{}
	),

	-- 21. implement Trait
	s(
		"impt",
		fmta(
			[[
	            impl <1> for <2> {
	                <3>
	            }
	            ]],
			{
				i(1, "Trait"),
				i(2, "Type"),
				i(3, "// add code here"),
			}
		),
		{}
	),

	-- 22. main
	s(
		"main",
		fmta(
			[[
	            fn main() {
	                <1>
	            }
	            ]],
			{
				i(1, "todo!();"),
			}
		),
		{}
	),

	-- 23. match
	s("rmatch", fmta("match <1> {}", { i(1, "expr") }), {}),

	-- 23. Mod Block
	s(
		"rmod",
		fmta(
			[[
	            mod <1> {
	                <2>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "// add code here"),
			}
		),

		{}
	),

	-- 24. Struct Tuple
	s("tstruct", fmta("struct <1>(<2>);", { i(1, "Name"), i(2, "Type") }), {}),

	-- 25. Struct Unit
	s("ustruct", fmta("struct <1>;", { i(1, "Name") }), {}),

	-- 26. struct
	s(
		"struct",
		fmta(
			[[
	           #[derive(Debug)]
	           struct <1> {
	               <2>: <3>,
	           }

	           impl <> {
	             <>
	           }
	           ]],
			{
				i(1, "Name"),
				i(2, "field"),
				i(3, "Type"),
				rep(1), -- This passes the rep function as an argument, implicitly linked to the next empty placeholder (<>)
				i(0),
			}
		),
		{}
	),

	-- 27. Mod Unit Test
	s(
		"modtest",
		fmta(
			[[
	            #[cfg(test)]
	            mod tests {
	              use super::*;

	                #[test]
	                fn <1>() {
	                    <2>
	                }
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "todo!();"),
			}
		),

		{}
	),

	-- 28. test
	s(
		"test",
		fmta(
			[[
	            #[test]
	            fn <1>() {
	                <2>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "todo!();"),
			}
		),

		{}
	),

	-- 29. trait
	s(
		"trait",
		fmta(
			[[
	            trait <1> {
	                <2>
	            }
	            ]],
			{
				i(1, "Name"),
				i(2, "// add code here"),
			}
		),

		{}
	),

	-- 30. type
	s("type", fmta("type <1> = <2>;", { i(1, "Alias"), i(2, "Type") })),

	-- 31. While Let (Autosnippet)
	s(
		"wlet",
		fmta(
			[[
	            while let <1> = <2> {
	                <0>
	            }
	            ]],
			{
				i(1, "Some(pat)"),
				i(2, "expr"),
				[0] = i(0, "todo!();"),
			}
		),

		{}
	),

	-- 32. While
	s(
		"while",
		fmta(
			[[
	            while <1> {
	                <2>
	            }
	            ]],
			{
				i(1, "condition"),
				i(2, "todo!();"),
			}
		),

		{}
	),

	-- 33. Public Async Return Function
	s(
		"parfn",
		fmta(
			[[
	            pub async fn <1>(<2>: <3>) ->> <4> {
	                <5>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "RetType"),
				i(5, "todo!();"),
			}
		),

		{}
	),

	-- 34. Async Return Function
	s(
		"arfn",
		fmta(
			[[
	            async fn <1>(<2>: <3>) ->> <4> {
	                <5>
	            }
	            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "RetType"),
				i(5, "todo!();"),
			}
		),

		{}
	),

	-- 35. Comment
	s(
		"comment",
		fmta(
			[[
	            /// <1>
	            ///
	            /// # Arguments
	            ///
	            /// * <3> - <4>
	            ///
	            /// # Returns
	            /// <2>
	            ///
	            /// # Examples
	            /// ```rust
	            /// <5>
	            /// ```
	            <0>]], -- Explicitly use <0> for final cursor position
			{
				i(1, "Description."),
				i(2, "type and description of the returned object."),
				i(3, "argument_name"),
				i(4, "type and description."),
				i(5, "write me later"),
				[0] = i(0), -- Ensure i(0) is mapped
			}
		),

		{}
	),

	-- 36. Test Doc
	s(
		"tdoc", -- Renamed from "test" to avoid conflict with `rtest` from main list
		fmta(
			[[
	            /// <1>
	            ///
	            /// # Examples
	            /// ```rust
	            /// <2>
	            /// ```
	            <0>]], -- Explicitly use <0> for final cursor position
			{
				i(1, "Description."),
				i(2, "write me later"),
				[0] = i(0), -- Ensure i(0) is mapped
			}
		),

		{}
	),
}, { key = "rust_auto_snippets" })
