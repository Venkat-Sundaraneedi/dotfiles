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
    "nvim-tree/nvim-web-devicons",
    opts = {
      color_icons = true,
      override_by_extension = {
        ["cairo"] = {
          icon = "󰪇",
          color = "#5f87d7",
          name = "Move",
        },
        ["nr"] = {
          icon = "", -- Logic gate/circuit diagram
          color = "#d3869b", -- Muted purple
          name = "Noir",
        },
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
