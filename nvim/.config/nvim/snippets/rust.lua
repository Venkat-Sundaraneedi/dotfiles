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

	-- 1. allow (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 2. deny (Autosnippet)
	s(
		"deny",
		fmta("#![deny(<1>)]", {
			c(1, {
				t("warnings"),
				t("unconditional_panic"),
				i(nil, "your_custom_lint"),
			}),
		}),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 3. warn (Autosnippet)
	s(
		"warn",
		fmta("#![warn(<1>)]", {
			c(1, {
				t("unused_imports"),
				t("unreachable_code"),
				i(nil, "your_custom_lint"),
			}),
		}),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 4. let (Autosnippet)
	s(
		"let",
		fmta("let <1> = <2>;", {
			i(1, "var"),
			i(2, "equal"),
		}),
		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 5. cfg (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 6. format_bang (Autosnippet)
	s(
		"format", -- Renamed from `rformat` to `rformat_bang` for uniqueness
		fmta('format!("<1>")', { i(1, "Hello, {}!") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 7. panic (Autosnippet)
	s(
		"panic",
		fmta('panic!("<1>");', { i(1, "Error message: {}") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 8. println (Autosnippet)
	s(
		"print",
		fmta('println!("<1>");', { i(1, "Hello, world!") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 9. vec_bang (Autosnippet)
	s(
		"rvec",
		fmta("vec![<1>]", { i(1, "elem1, elem2") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 10. assert_bang (Autosnippet)
	s(
		"assert",
		fmta("assert!(<1>);", { i(1, "condition") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 11. assert_eq_bang (Autosnippet)
	s(
		"eqassert",
		fmta("assert_eq!(<1>, <2>);", { i(1, "expected"), i(2, "actual") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 12. const (Autosnippet)
	s(
		"const",
		fmta([[const <1>: <2> = <3>;]], {
			i(1, "CONST_NAME"),
			i(2, "Type"),
			i(3, "init_value"),
		}),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 13. derive (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 14. enum (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 15. Public Return Function (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 16. Function (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 17. Return Function (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 18. for (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 19. rif_let (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 20. if (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 21. implement Trait (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 22. main (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 23. match (Autosnippet)
	s("rmatch", fmta("match <1> {}", { i(1, "expr") }), { condition = create_not_in_comment_or_string_condition() }),

	-- 23. Mod Block (Autosnippet)
	s(
		"mod",
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 24. Struct Tuple (Autosnippet)
	s(
		"tstruct",
		fmta("struct <1>(<2>);", { i(1, "Name"), i(2, "Type") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 25. Struct Unit
	s("ustruct", fmta("struct <1>;", { i(1, "Name") }), { condition = create_not_in_comment_or_string_condition() }),

	-- 26. struct (Autosnippet)
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
		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 27. Mod Unit Test (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 28. test (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 29. trait (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 30. type (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 32. While (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 33. Public Async Return Function (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 34. Async Return Function (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 35. Comment (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 36. Test Doc (Autosnippet)
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

		{ condition = create_not_in_comment_or_string_condition() }
	),
}, { type = "autosnippets", key = "rust_auto_snippets" }) -- Mark as autosnippets and give it a key
