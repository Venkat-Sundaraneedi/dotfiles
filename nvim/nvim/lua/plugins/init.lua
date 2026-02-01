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

  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   opts = {
  --     color_icons = true,
  --     override_by_extension = {
  --       ["nr"] = {
  --         icon = "",
  --         color = "#d3869b",
  --         name = "Noir",
  --       },
  --     },
  --   },
  -- },

}
