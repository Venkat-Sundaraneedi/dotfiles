dofile(vim.g.base46_cache .. "blink")

local opts = {
  snippets = { preset = "luasnip" },
  cmdline = {
    enabled = true,
  },
  appearance = { nerd_font_variant = "normal" },
  fuzzy = {
    implementation = "rust",

    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },

  signature = { enabled = true, window = { border = "single", show_documentation = false } },
  sources = { default = { "lsp", "snippets", "buffer", "path" } },

  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<Tab>"] = {},
    ["<S-Tab>"] = {},
    ["<C-space>"] = { "hide", "show" },
  },

  completion = {
    ghost_text = { enabled = false },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "single" },
    },
    accept = { auto_brackets = { enabled = true } },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    menu = require("nvchad.blink").menu,
  },
}

return opts
