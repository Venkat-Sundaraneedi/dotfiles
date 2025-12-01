local ls = require "luasnip"
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
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

ls.add_snippets("move", {}, { key = "move_manual_snippets" })

-- Add regular snippets for Move language
ls.add_snippets("move", {
  -- Basic module structure
  s(
    "module",
    fmta(
      [[
      module <1>::<2> {
          <0>
      }
      ]],
      {
        i(1, "addr"),
        i(2, "module_name"),
        [0] = i(0),
      }
    )
  ),
  -- Script structure
  s(
    "script",
    fmta(
      [[
      script {
          use <1>::<2>;
          fun main(<3>) {
              <0>
          }
      }
      ]],
      {
        i(1, "addr"),
        i(2, "module_name"),
        i(3, "account: &signer"),
        [0] = i(0),
      }
    )
  ),

  -- Resource struct with key and store
  s(
    "resource",
    fmta(
      [[
      struct <1> has key, store {
          <0>
      }
      ]],
      {
        i(1, "ResourceName"),
        [0] = i(0),
      }
    )
  ),

  -- Public entry function
  s(
    "entry",
    fmta(
      [[
      public entry fun <1>(<2>) {
          <0>
      }
      ]],
      {
        i(1, "function_name"),
        i(2, "account: &signer"),
        [0] = i(0),
      }
    )
  ),

  -- Simple struct with store
  s(
    "struct",
    fmta(
      [[
      struct <1> has store {
          <2>: <3>,
      }
      ]],
      {
        i(1, "StructName"),
        i(2, "field"),
        i(3, "u64"),
      }
    )
  ),
  -- Public function with return
  s(
    "pub",
    fmta(
      [[
      public fun <1>(<2>): <3> {
          <0>
      }
      ]],
      {
        i(1, "function_name"),
        i(2, ""),
        i(3, "u64"),
        [0] = i(0),
      }
    )
  ),

  -- Private function
  s(
    "fun",
    fmta(
      [[
      fun <1>(<2>): <3> {
          <0>
      }
      ]],
      {
        i(1, "function_name"),
        i(2, ""),
        i(3, "u64"),
        [0] = i(0),
      }
    )
  ),

  -- View function (public with no mutation)
  s(
    "view",
    fmta(
      [[
      public fun view_<1>(<2>): <3> {
          <0>
      }
      ]],
      {
        i(1, "resource_name"),
        i(2, "owner: address"),
        i(3, "u64"),
        [0] = i(0),
      }
    )
  ),

  -- Test function
  s(
    "testf",
    fmta(
      [[
      #[test]
      fun test_<1>() {
          <0>
      }
      ]],
      {
        i(1, "function_name"),
        [0] = i(0),
      }
    )
  ),

  -- Test function expected_failure
  s(
    "testfail",
    fmta(
      [[
      #[test]
      #[expected_failure]
      fun test_<1>() {
          <0>
      }
      ]],
      {
        i(1, "function_name"),
        [0] = i(0),
      }
    )
  ),

  -- Use statement
  s(
    "use",
    fmta("use <1>::<2>;", {
      i(1, "addr"),
      i(2, "module_name"),
    })
  ),
  -- Constant declaration
  s(
    "const",
    fmta(
      [[
      const <1>: <2> = <3>;
      ]],
      {
        i(1),
        i(2, "u64"),
        i(3, "0"),
      }
    )
  ),

  -- Friend declaration
  s(
    "friend",
    fmta(
      [[
      friend <1>::<2>;
      ]],
      {
        i(1, "addr"),
        i(2, "module_name"),
      }
    )
  ),

  -- Assert macro
  s(
    "assert",
    fmta(
      [[
      assert!(<1>, <2>);
      ]],
      {
        i(1, "condition"),
        i(2, "error_code"),
      }
    )
  ),

  -- Let statement
  s(
    "let",
    fmta(
      [[
      let <1> = <2>;
      ]],
      {
        i(1, "variable"),
        i(2, "value"),
      }
    )
  ),

  -- If statement
  s(
    "if",
    fmta(
      [[
      if (<1>) {
          <0>
      }
      ]],
      {
        i(1, "condition"),
        [0] = i(0),
      }
    )
  ),

  -- Return statement
  s(
    "return",
    fmta(
      [[
      return <1>;
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  -- Vector operations
  s(
    "vector",
    fmta(
      [[
      vector[];
      ]],
      {}
    )
  ),

  -- Option some
  s(
    "some",
    fmta(
      [[
      option::some(<1>)
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  -- Option none
  s(
    "none",
    fmta(
      [[
      option::none()
      ]],
      {}
    )
  ),

  -- If-else statement
  s(
    "ifelse",
    fmta(
      [[
      if (<1>) {
          <2>
      } else {
          <0>
      }
      ]],
      {
        i(1, "condition"),
        i(2, "// then branch"),
        [0] = i(0),
      }
    )
  ),

  -- While loop
  s(
    "while",
    fmta(
      [[
      while (<1>) {
          <0>
      }
      ]],
      {
        i(1, "condition"),
        [0] = i(0),
      }
    )
  ),

  -- Loop
  s(
    "loop",
    fmta(
      [[
      loop {
          <0>
      }
      ]],
      {
        [0] = i(0),
      }
    )
  ),

  -- Abort with error code
  s(
    "abort",
    fmta(
      [[
      abort <1>;
      ]],
      {
        i(1, "error_code"),
      }
    )
  ),

  -- Debug print
  s(
    "debug",
    fmta(
      [[
      debug::print(&<1>);
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  -- print
  s(
    "print",
    fmta(
      [[
      print(&<1>);
      ]],
      {
        i(1, "value"),
      }
    )
  ),

  -- Documentation comment
  s(
    "doc",
    fmta(
      [[
      /// <1>
      /// <2>
      <0>]],
      {
        i(1, "Function description"),
        i(2, "@param param_name parameter description"),
        [0] = i(0),
      }
    )
  ),

  -- Error codes
  s(
    "error",
    fmta(
      [[
      const <1>: u64 = <2>;
      ]],
      {
        i(1),
        i(2, "1"),
      }
    )
  ),

  -- Vector push back
  s(
    "vector_push",
    fmta(
      [[
      vector::push_back(&mut <1>, <2>);
      ]],
      {
        i(1, "vec"),
        i(2, "element"),
      }
    )
  ),

  -- Vector pop back
  s(
    "vector_pop",
    fmta(
      [[
      vector::pop_back(&mut <1>);
      ]],
      {
        i(1, "vec"),
      }
    )
  ),

  -- Test
  s(
    "test",
    fmta(
      [[
      #[test]<0>
      ]],
      {
        [0] = i(0),
      }
    )
  ),
  -- Test-only function
  s(
    "test_only",
    fmta(
      [[
      #[test_only]
        <0>
      ]],
      {
        [0] = i(0),
      }
    )
  ),

  -- String operations
  s(
    "string",
    fmta(
      [[
      utf8(b"<1>")
      ]],
      {
        i(1, "text"),
      }
    )
  ),

  -- Use with alias
  s(
    "useas",
    fmta(
      [[
      use <1>::<2> as <3>;
      ]],
      {
        i(1, "addr"),
        i(2, "module_name"),
        i(3, "alias"),
      }
    )
  ),

  -- Event structure
  s(
    "event",
    fmta(
      [[
      struct <1> has drop, store {
          <0>
      }
      ]],
      {
        i(1, "EventName"),
        [0] = i(0),
      }
    )
  ),

  -- Native function
  s(
    "native",
    fmta(
      [[
      native public fun <1>(<2>);
      ]],
      {
        i(1, "function_name"),
        i(2, ""),
      }
    )
  ),

  -- Module documentation
  s(
    "moddoc",
    fmta(
      [[
      /// <1>
      /// <2>
      /// 
      /// # Overview
      /// <3>
      <0>]],
      {
        i(1, "Module Name"),
        i(2, "Copyright notice"),
        i(3, "Module description"),
        [0] = i(0),
      }
    )
  ),

  -- Borrow global (fixed with fmt)
  s(
    "borrow_global",
    fmt("borrow_global<{}>({})", {
      i(1, "Resource"),
      i(2, "addr"),
    })
  ),

  -- Borrow global mutable
  s(
    "borrow_global_mut",
    fmt("borrow_global_mut<{}>({})", {
      i(1, "Resource"),
      i(2, "addr"),
    })
  ),

  -- Move from
  s(
    "move_from",
    fmt("move_from<{}>({})", {
      i(1, "Resource"),
      i(2, "addr"),
    })
  ),

  -- Exists check
  s(
    "exists",
    fmt("exists<{}>({})", {
      i(1, "Resource"),
      i(2, "addr"),
    })
  ),

  -- Signer address
  s(
    "signer",
    fmt("signer::address_of({})", {
      i(1, "account"),
    })
  ),

  -- Vector length
  s(
    "vector_length",
    fmt("vector::length(&{})", {
      i(1, "vec"),
    })
  ),

  -- Vector empty
  s(
    "vector_empty",
    fmt("vector::empty<{}>()", {
      i(1, "Element"),
    })
  ),

  -- Capability pattern
  s(
    "capability",
    fmta(
      [[
      struct <1> has key, store {
          dummy_field: bool
      }

      public fun create_<1>(account: &signer) {
          move_to(account, <1> { dummy_field: true })
      }
      ]],
      {
        i(1, "Capability"),
      }
    )
  ),

  -- Timestamp operations
  s("timestamp", fmt("timestamp::now_microseconds()", {})),

  -- GUID creation
  s(
    "guid",
    fmt("account::create_guid({})", {
      i(1, "account"),
    })
  ),
}, { key = "move_snippets" })
