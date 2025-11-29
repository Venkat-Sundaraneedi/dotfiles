return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    opts = require "configs.lspconfig",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      return require "configs.blink"
    end,
    opts_extend = { "sources.default" },
  },
}
