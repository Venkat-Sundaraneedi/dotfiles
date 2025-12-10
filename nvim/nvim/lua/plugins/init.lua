return {
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    -- event = "BufWritePre",
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

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
    opts = {
      preview = {
        icon_provider = "internal", -- "mini" or "devicons"
      },
    },
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
  },
}
