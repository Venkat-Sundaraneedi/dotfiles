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

  { "catppuccin/nvim", name = "catppuccin" },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
