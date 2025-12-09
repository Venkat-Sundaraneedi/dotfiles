return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter-textobjects"
    end,
    config = function(_, opts)
      require("nvim-treesitter").setup { opts }
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      color_icons = true,
      override_by_extension = {
        ["move"] = {
          icon = "󰪇",
          color = "#5f87d7",
          name = "Move",
        },
        ["ron"] = {
          icon = "󰪇",
          color = "#5f87d7",
          name = "Move",
        },
      },
    },
  },
  {
    "fei6409/log-highlight.nvim",
    opts = {},
  },
}
