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

ls.add_snippets("rust", {}, { key = "rust_manual_snippets" }) -- Good practice to add a key for reloading

-- Add AUTO snippets with the 'r' prefix
ls.add_snippets("rust", {

	-- 1. rallow (Autosnippet)
	s(
		"rallow",
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
		)
	),

	-- 2. rdeny (Autosnippet)
	s(
		"rdeny",
		fmta("#![deny(<1>)]", {
			c(1, {
				t("warnings"),
				t("unconditional_panic"),
				i(nil, "your_custom_lint"),
			}),
		})
	),

	-- 3. rwarn (Autosnippet)
	s(
		"rwarn",
		fmta("#![warn(<1>)]", {
			c(1, {
				t("unused_imports"),
				t("unreachable_code"),
				i(nil, "your_custom_lint"),
			}),
		})
	),

	-- 4. rno_std (Corrected)
	s("rno_std", fmta("#![no_std]", {})), -- Pass an empty table as the second argument

	-- 5. rno_core (Corrected)
	s("rno_core", fmta("#![no_core]", {})), -- Pass an empty table as the second argument

	-- 6. rfeature (This one was correct as it had an argument)
	s(
		"rfeature",
		fmta("#![feature(<1>)]", {
			c(1, {
				t("const_generics"),
				t("async_fn_in_trait"),
				t("adt_const_params"),
				i(nil, "your_custom_feature"),
			}),
		})
	),

	-- 7. rmacro_use
	s(
		"rmacro_use",
		fmta("#[macro_use(<1>)]", {
			c(1, { -- Choice node for common macro uses
				t("crate_name"), -- Example: #[macro_use(crate_name)]
				t("foo, bar"), -- Example: #[macro_use(foo, bar)]
				i(nil, "your_macro_attr"), -- Custom input
			}),
		})
	),

	-- 8. rrepr
	s(
		"rrepr",
		fmta("#[repr(<1>)]", {
			c(1, { -- Choice node for common repr attributes
				t("C"),
				t("align(N)"),
				t("packed"),
				t("transparent"),
				t("Rust"),
				i(nil, "custom_repr"), -- Custom input
			}),
		})
	),

	-- 9. rcfg
	s(
		"rcfg",
		fmta("#[cfg(<1>)]", {
			c(1, { -- Choice node for common cfg attributes
				t("test"),
				t("debug_assertions"),
				t('target_os = "linux"'),
				t('feature = "my_feature"'),
				i(nil, ""), -- Empty insert node: LSP suggestions trigger here
			}),
		})
	),

	-- 10. rcfg_attr
	s(
		"rcfg_attr",
		fmta("#[cfg_attr(<1>, <2>)]", {
			c(1, { -- Choice node for common cfg_attr conditions
				t("test"),
				t("debug_assertions"),
				t('target_os = "linux"'),
				t('feature = "my_feature"'),
				i(nil, "custom_cfg_condition"),
			}),
			i(2, "attribute"), -- Second tab stop for the attribute itself
		})
	),

	-- 11. rcfg_bang
	s(
		"rcfg_bang", -- Renamed from `rcfg!` to `rcfg_bang` for uniqueness and Lua identifier compatibility
		fmta("cfg!(<1>)", {
			c(1, {
				t("test"),
				t("debug_assertions"),
				t('target_os = "linux"'),
				t('feature = "my_feature"'),
				i(nil, ""),
			}),
		})
	),

	-- 12. rcolumn
	s("rcolumn", fmta("column!()", {})),

	-- 13. rconcat_bang
	s(
		"rconcat_bang", -- Renamed from `rconcat` to `rconcat_bang` for uniqueness
		fmta("concat!(<1>)", { i(1, '"string1", "string2"') })
	),

	-- 14. rconcat_idents_bang
	s(
		"rconcat_idents_bang", -- Renamed from `rconcat_idents` to `rconcat_idents_bang` for uniqueness
		fmta("concat_idents!(<1>)", { i(1, "ident1, ident2") })
	),

	-- 15. rdebug_assert_bang
	s(
		"rdebug_assert_bang", -- Renamed from `rdebug_assert` to `rdebug_assert_bang` for uniqueness
		fmta("debug_assert!(<1>);", { i(1, "condition") })
	),

	-- 16. rdebug_assert_eq_bang
	s(
		"rdebug_assert_eq_bang", -- Renamed from `rdebug_assert_eq` to `rdebug_assert_eq_bang` for uniqueness
		fmta("debug_assert_eq!(<1>, <2>);", { i(1, "expected"), i(2, "actual") })
	),

	-- 17. renv
	s("renv", fmta('env!("<1>")', { i(1, "ENV_VAR_NAME") })),

	-- 18. rfile
	s("rfile", fmta("file!()", {})),

	-- 19. rformat_bang
	s(
		"rformat_bang", -- Renamed from `rformat` to `rformat_bang` for uniqueness
		fmta('format!("<1>")', { i(1, "Hello, {}!") })
	),

	-- 20. rformat_args_bang
	s(
		"rformat_args_bang", -- Renamed from `rformat_args` to `rformat_args_bang` for uniqueness
		fmta('format_args!("<1>")', { i(1, "key = value") })
	),

	-- 21. rinclude
	s("rinclude", fmta('include!("<1>");', { i(1, "path/to/file.rs") })),

	-- 22. rinclude_bytes
	s("rinclude_bytes", fmta('include_bytes!("<1>")', { i(1, "path/to/asset.bin") })),

	-- 23. rinclude_str
	s("rinclude_str", fmta('include_str!("<1>")', { i(1, "path/to/asset.txt") })),

	-- 24. rline
	s("rline", fmta("line!()", {})),

	-- 25. rmodule_path
	s("rmodule_path", fmta("module_path!()", {})),

	-- 26. roption_env
	s("roption_env", fmta('option_env!("<1>")', { i(1, "ENV_VAR_NAME") })),

	-- 27. rpanic
	s("rpanic", fmta('panic!("<1>");', { i(1, "Error message: {}") })),

	-- 28. rprint
	s("rprint", fmta('print!("<1>");', { i(1, "Debug info: {}") })),

	-- 29. rprintln
	s("rprintln", fmta('println!("<1>");', { i(1, "Hello, world!") })),

	-- 30. rstringify
	s("rstringify", fmta("stringify!(<1>)", { i(1, "expression") })),

	-- 31. rthread_local
	s(
		"rthread_local",
		fmta([[thread_local!(static <1>: <2> = <3>);]], {
			i(1, "STATIC_NAME"),
			i(2, "Type"),
			i(3, "init"),
		})
	),

	-- 32. rtry_bang
	s(
		"rtry_bang", -- Renamed for uniqueness, as "try" could conflict with other keywords
		fmta("try!(<1>)", { i(1, "expression") })
	),

	-- 33. runimplemented
	s("runimplemented", fmta("unimplemented!()", {})),

	-- 34. runreachable_bang
	s(
		"runreachable_bang", -- Renamed for uniqueness
		fmta("unreachable!(<1>)", { i(1, "reason_message") })
	),

	-- 35. rvec_bang
	s(
		"rvec_bang", -- Renamed for uniqueness
		fmta("vec![<1>]", { i(1, "elem1, elem2") })
	),

	-- 36. rwrite_bang
	s(
		"rwrite_bang", -- Renamed for uniqueness
		fmta('write!(<1>, "<2>")', { i(1, "writer"), i(2, "format_string") })
	),

	-- 37. rwriteln_bang
	s(
		"rwriteln_bang", -- Renamed for uniqueness
		fmta('writeln!(<1>, "<2>")', { i(1, "writer"), i(2, "format_string") })
	),

	-- 38. rassert_bang
	s(
		"rassert_bang", -- Renamed for uniqueness
		fmta("assert!(<1>);", { i(1, "condition") })
	),

	-- 39. rassert_eq_bang
	s(
		"rassert_eq_bang", -- Renamed for uniqueness
		fmta("assert_eq!(<1>, <2>);", { i(1, "expected"), i(2, "actual") })
	),

	-- 40. rbench
	s(
		"rbench",
		fmta(
			[[
            #[bench]
            fn <1>(b: &mut test::Bencher) {
                <2>
            }
            ]],
			{
				i(1, "name"),
				i(2, "b.iter(|| /* benchmark code */)"),
			}
		)
	),

	-- 41. rconst
	s(
		"rconst",
		fmta([[const <1>: <2> = <3>;]], {
			i(1, "CONST_NAME"),
			i(2, "Type"),
			i(3, "init_value"),
		})
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
		})
	),

	-- 43. renum
	s(
		"renum",
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
		)
	),

	-- 44. rextern_crate
	s("rextern_crate", fmta("extern crate <1>;", { i(1, "name") })),

	-- 45. rextern_fn
	s(
		"rextern_fn",
		fmta(
			[[
            extern "C" fn <1>(<2>: <3>) ->> <4> { -- Corrected `->>`
                <5>
            }
            ]],
			{
				i(1, "name"),
				i(2, "arg"),
				i(3, "Type"),
				i(4, "RetType"),
				i(5, "// add code here"),
			}
		)
	),

	-- 46. rextern_mod
	s(
		"rextern_mod",
		fmta(
			[[
            extern "C" {
                <1>
            }
            ]],
			{
				i(1, "// add code here"), -- Final tab stop for foreign function declarations
			}
		)
	),

	-- 47. rpfn (Public Function)
	s(
		"rpfn",
		fmta(
			[[
            pub fn <1>(<2>: <3>) ->> <4> { -- Corrected `->>`
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
		)
	),

	-- 48. rfn (Function)
	s(
		"rfn",
		fmta(
			[[
            fn <1>(<2>: <3>) ->> <4> { -- Corrected `->>`
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
		)
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
		)
	),

	-- 50. rif_let
	s(
		"rif_let",
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
		)
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
		)
	),

	-- 52. rimpl_trait
	s(
		"rimpl_trait",
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
		)
	),

	-- 53. rinline_fn
	s(
		"rinline_fn",
		fmta( -- Correct: No `->>` needed as per original JSON
			[[
            #[inline]
            pub fn <1>() {
                <2>
            }
            ]],
			{
				i(1, "name"),
				i(2, "todo!();"),
			}
		)
	),

	-- 54. rmacro_rules
	s(
		"rmacro_rules",
		fmta(
			[[
            macro_rules! <1> {
                (<2>) =>> (<3>)
            }
            ]],
			{
				i(1, "name"),
				i(2, "pattern"),
				i(3, "expansion"),
			}
		)
	),

	-- 55. rmain
	s(
		"rmain",
		fmta(
			[[
	           fn main() {
	               <1>
	           }
	           ]],
			{
				i(1, "todo!();"),
			}
		)
	),

	-- 56. rmatch
	s("rmatch", fmta("match <1> {}", { i(1, "expr") })),

	-- 57. rmod_block
	s(
		"rmod_block",
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
		)
	),

	-- 58. rstatic
	s(
		"rstatic",
		fmta([[static <1>: <2> = <3>;]], {
			i(1, "STATIC_NAME"),
			i(2, "Type"),
			i(3, "init_value"),
		})
	),

	-- 59. rstruct_tuple
	s("rstruct_tuple", fmta("struct <1>(<2>);", { i(1, "Name"), i(2, "Type") })),

	-- 60. rstruct_unit
	s("rstruct_unit", fmta("struct <1>;", { i(1, "Name") })),

	-- 61. rstruct (Full struct definition)

	s(
		"rstruct",
		fmta(
			[[
	           #[derive(Debug)]
	           struct <1> {
	               <2>: <3>,
	           }
	           ]],
			{
				i(1, "Name"),
				i(2, "field"),
				i(3, "Type"),
			}
		)
	),

	-- 61. rmodtest
	s(
		"rmodtest",
		fmta(
			[[
            #[cfg(test)]
            mod test {
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
		)
	),

	-- 62. rtest (Bare #[test] function)
	s(
		"rtest",
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
		)
	),

	-- 63. rtrait
	s(
		"rtrait",
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
		)
	),

	-- 64. rtype (Type alias)
	s("rtype", fmta("type <1> = <2>;", { i(1, "Alias"), i(2, "Type") })),

	-- 65. rwhile_let
	s(
		"rwhile_let",
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
		)
	),

	-- 66. rwhile
	s(
		"rwhile",
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
		)
	),

	-- 67. rpafn (Public Async Function)
	s(
		"rpafn",
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
		)
	),

	-- 68. rafn (Async Function)
	s(
		"rafn",
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
		)
	),

	-- 69. rcomment (Doc comment with arguments, returns, examples)
	s(
		"rcomment",
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
		)
	),

	-- 70. rcrate (Crate-level doc comment)
	s(
		"rcrate",
		fmta(
			[[
            //! <1>
            //!
            //! # Examples
            //! ```rust
            //! <2>
            //! ```
            <0>]], -- Explicitly use <0> for final cursor position
			{
				i(1, "Description."),
				i(2, "write me later"),
				[0] = i(0), -- Ensure i(0) is mapped
			}
		)
	),

	-- 71. rtest_doc (Doc comment for a test)
	s(
		"rtest_doc", -- Renamed from "test" to avoid conflict with `rtest` from main list
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
		)
	),

	-- 72. rhtml_favicon_url
	s(
		"rhtml_favicon_url",
		fmta([[#![doc(html_favicon_url = "<1>")]<0>]], {
			i(1, "https://example.com/favicon.ico"),
			[0] = i(0),
		})
	),

	-- 73. rhtml_logo_url
	s(
		"rhtml_logo_url",
		fmta([[#![doc(html_logo_url = "<1>")]<0>]], {
			i(1, "https://example.com/logo.jpg"),
			[0] = i(0),
		})
	),

	-- rhtml_playground_url
	s(
		"rhtml_playground_url",
		fmta([[#![doc(html_playground_url = "<1>")]<0>]], {
			i(1, "https://playground.example.com/"),
			[0] = i(0),
		})
	),

	-- rissue_tracker_base_url
	s(
		"rissue_tracker_base_url",
		fmta([[#![doc(issue_tracker_base_url = "<1>")]<0>]], {
			i(1, "https://github.com/rust-lang/rust/issues/"),
			[0] = i(0),
		})
	),

	-- rhtml_root_url
	s(
		"rhtml_root_url",
		fmta([[#![doc(html_root_url = "<1>")]<0>]], {
			i(1, "https://docs.rs/serde/1.0"),
			[0] = i(0),
		})
	),

	-- rhtml_no_source
	s(
		"rhtml_no_source",
		fmta([[#![doc(html_no_source)]<0>]], {
			[0] = i(0),
		})
	),

	-- rtest_no_crate_inject
	s(
		"rtest_no_crate_inject",
		fmta([[#![doc(test(no_crate_inject))]<0>]], {
			[0] = i(0),
		})
	),

	-- rtest_attr
	s(
		"rtest_attr",
		fmta([[#![doc(test(attr(deny(warnings))))]<0>]], {
			[0] = i(0),
		})
	),

	-- rinline_doc_attr (renamed from `inline` to avoid keyword conflict)
	s(
		"rinline_doc_attr",
		fmta([[#[doc(inline)]<0>]], {
			[0] = i(0),
		})
	),

	-- rno_inline_doc_attr (renamed from `no_inline` to avoid keyword conflict)
	s(
		"rno_inline_doc_attr",
		fmta([[#[doc(no_inline)]<0>]], {
			[0] = i(0),
		})
	),

	-- rhidden (doc hidden)
	s(
		"rhidden",
		fmta([[#[doc(hidden)]<0>]], {
			[0] = i(0),
		})
	),

	-- ralias_doc_attr (renamed from `alias` to avoid keyword conflict)
	s(
		"ralias_doc_attr",
		fmta([[#[doc(alias = "<1>")]<0>]], {
			i(1, "name"),
			[0] = i(0),
		})
	),

	-- rbroken_intra_doc_links (Revised for Lua formatter compatibility)
	s("rbroken_intra_doc_links", {
		t("#!["),
		c(1, { -- Choice for warning level
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::broken_intra_doc_links)]"),
		i(0),
	}),

	-- rprivate_intra_doc_links (Revised for Lua formatter compatibility)
	s("rprivate_intra_doc_links", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::private_intra_doc_links)]"),
		i(0),
	}),

	-- rmissing_docs (Revised for Lua formatter compatibility)
	s("rmissing_docs", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(missing_docs)]"),
		i(0),
	}),

	-- rmissing_crate_level_docs (Revised for Lua formatter compatibility)
	s("rmissing_crate_level_docs", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::missing_crate_level_docs)]"),
		i(0),
	}),

	-- rmissing_doc_code_examples (Revised for Lua formatter compatibility)
	s("rmissing_doc_code_examples", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::missing_doc_code_examples)]"),
		i(0),
	}),

	-- rprivate_doc_tests (Revised for Lua formatter compatibility)
	s("rprivate_doc_tests", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::private_doc_tests)]"),
		i(0),
	}),

	-- rinvalid_codeblock_attributes (Revised for Lua formatter compatibility)
	s("rinvalid_codeblock_attributes", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::invalid_codeblock_attributes)]"),
		i(0),
	}),

	-- rinvalid_html_tags (Revised for Lua formatter compatibility)
	s("rinvalid_html_tags", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::invalid_html_tags)]"),
		i(0),
	}),

	-- rinvalid_rust_codeblocks (Revised for Lua formatter compatibility)
	s("rinvalid_rust_codeblocks", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::invalid_rust_codeblocks)]"),
		i(0),
	}),

	-- rbare_urls (Revised for Lua formatter compatibility)
	s("rbare_urls", {
		t("#!["),
		c(1, {
			t("warn"),
			t("allow"),
			t("deny"),
		}),
		t("(rustdoc::bare_urls)]"),
		i(0),
	}),

	--
	-- rcfg_doc_attr (renamed from `cfg` to avoid conflict with `rcfg` and `rcfg_bang`)
	s(
		"rcfg_doc_attr",
		fmta([[#[cfg(any(<1>, doc))]<0>]], {
			c(1, { -- Common cfg conditions
				t("unix"),
				t("windows"),
				t('target_arch = "wasm32"'),
				i(nil, "your_custom_cfg"),
			}),
			[0] = i(0),
		})
	),
}, { type = "autosnippets", key = "rust_auto_snippets" }) -- Mark as autosnippets and give it a key
