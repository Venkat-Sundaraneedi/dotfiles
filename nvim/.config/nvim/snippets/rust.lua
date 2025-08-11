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

	s(
		"rlet",
		fmta("let <1> = <2>;", {
			i(1, "var"),
			i(2, "equal"),
		}),
		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 1. rallow (Autosnippet)
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

	-- 2. rdeny (Autosnippet)
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

	-- 3. rwarn (Autosnippet)
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

	-- 9. rcfg
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

	-- 19. rformat_bang
	s(
		"rformat", -- Renamed from `rformat` to `rformat_bang` for uniqueness
		fmta('format!("<1>")', { i(1, "Hello, {}!") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 27. rpanic
	s(
		"rpanic",
		fmta('panic!("<1>");', { i(1, "Error message: {}") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 29. rprintln
	s(
		"print",
		fmta('println!("<1>");', { i(1, "Hello, world!") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 35. rvec_bang
	s(
		"rvec", -- Renamed for uniqueness
		fmta("vec![<1>]", { i(1, "elem1, elem2") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 38. rassert_bang
	s(
		"assert_bang", -- Renamed for uniqueness
		fmta("assert!(<1>);", { i(1, "condition") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 39. rassert_eq_bang
	s(
		"assert_eq_bang", -- Renamed for uniqueness
		fmta("assert_eq!(<1>, <2>);", { i(1, "expected"), i(2, "actual") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 41. rconst
	s(
		"rconst",
		fmta([[const <1>: <2> = <3>;]], {
			i(1, "CONST_NAME"),
			i(2, "Type"),
			i(3, "init_value"),
		}),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 42. rderive
	s(
		"rderive",
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

	-- 43. renum
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

	-- 47. rpfn (Public Function)
	s(
		"pfn",
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

	-- 48. rfn (Function)
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

	-- 49. rfor
	s(
		"rfor",
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

	-- 50. rif_let
	s(
		"if_let",
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

	-- 51. rif
	s(
		"rif",
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

	-- 52. rimpl_trait
	s(
		"impl_trait",
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

	-- 55. rmain
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

	-- 56. rmatch
	s("match", fmta("match <1> {}", { i(1, "expr") }), { condition = create_not_in_comment_or_string_condition() }),

	-- 57. rmod_block
	s(
		"mod_block",
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

	-- 59. rstruct_tuple
	s(
		"rstruct_tuple",
		fmta("struct <1>(<2>);", { i(1, "Name"), i(2, "Type") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 60. rstruct_unit
	s(
		"rstruct_unit",
		fmta("struct <1>;", { i(1, "Name") }),

		{ condition = create_not_in_comment_or_string_condition() }
	),

	-- 61. rstruct (Full struct definition)

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

	-- 61. rmodtest
	s(
		"intest",
		fmta(
			[[
            #[cfg(test)]
            mod tests {
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

	-- 62. rtest (Bare #[test] function)
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

	-- 63. rtrait
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

	-- 64. rtype (Type alias)
	s("type", fmta("type <1> = <2>;", { i(1, "Alias"), i(2, "Type") })),

	-- 65. rwhile_let
	s(
		"while_let",
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

	-- 66. rwhile
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

	-- 67. rpafn (Public Async Function)
	s(
		"pafn",
		fmta(
			[[
            pub async fn <1>(<2>: <3>) ->> <4> { -- Corrected `->>`
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

	-- 68. rafn (Async Function)
	s(
		"afn",
		fmta(
			[[
            async fn <1>(<2>: <3>) ->> <4> { -- Corrected `->>`
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

	-- 69. rcomment (Doc comment with arguments, returns, examples)
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

	-- 71. rtest_doc (Doc comment for a test)
	s(
		"test_doc", -- Renamed from "test" to avoid conflict with `rtest` from main list
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
