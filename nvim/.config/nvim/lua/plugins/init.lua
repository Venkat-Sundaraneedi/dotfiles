return {
  -- inc-rename
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },

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

  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    branch = "main",
    opts = function()
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)
      return {
        ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "rust", "solidity" },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        indent = { enable = true },
      }
    end,
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter").setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

            keymaps = {
              -- Replicating mini.ai's 'o', 'f', 'c' (Tree-sitter based)
              ["ao"] = "@block.outer", -- 'a'round 'o'bject (general block/statement)
              ["io"] = "@block.inner", -- 'i'nner 'o'bject (general block/statement)
              ["af"] = "@function.outer", -- 'a'round 'f'unction
              ["if"] = "@function.inner", -- 'i'nner 'f'unction
              ["ac"] = "@class.outer", -- 'a'round 'c'lass
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" }, -- 'i'nner 'c'lass

              ["at"] = "@tag.outer", -- 'a'round 't'ag (for HTML, XML, JSX, TSX)
              ["it"] = "@tag.inner", -- 'i'nner 't'ag

              ["ad"] = "@number.outer", -- 'a'round 'd'igit/number
              ["id"] = "@number.inner", -- 'i'nner 'd'igit/number

              ["ae"] = "@identifier.outer", -- 'a'round 'e'lement (identifier/variable)
              ["ie"] = "@identifier.inner", -- 'i'nner 'e'lement

              ["ai"] = "@block.outer", -- 'a'round 'i'ndented block (syntax block)
              ["ii"] = "@block.inner", -- 'i'nner 'i'ndented block (syntax block)

              ["aC"] = "@conditional.outer", -- 'a'round 'C'onditional (using Cap C to avoid conflict)
              ["iC"] = "@conditional.inner", -- 'i'nner 'C'onditional
              ["aL"] = "@loop.outer", -- 'a'round 'L'oop (using Cap L)
              ["iL"] = "@loop.inner", -- 'i'nner 'L'oop
              ["aB"] = "@block.outer", -- 'a'round 'B'lock (using Cap B)
              ["iB"] = "@block.inner", -- 'i'nner 'B'lock

              -- Replicating mini.ai's 'u', 'U' (function call)
              ["au"] = "@call.outer", -- 'a'round 'u'se (function call)
              ["iu"] = "@call.inner", -- 'i'nner 'u'se

              -- Standard helpful text objects (parameters, assignments, statements)
              ["ap"] = "@parameter.outer", -- 'a'round 'p'arameter
              ["ip"] = "@parameter.inner", -- 'i'nner 'p'arameter
              ["a="] = "@assignment.outer", -- 'a'round 'assignment'
              ["i="] = "@assignment.inner", -- 'i'nner 'assignment'
              ["aS"] = "@statement.outer", -- 'a'round 'S'tatement
              ["iS"] = "@statement.inner", -- 'i'nner 'S'tatement (if available for language)
            },

            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
              ["@block.outer"] = "V", -- linewise selection for blocks
              ["@loop.outer"] = "V",
              ["@conditional.outer"] = "V",
              ["@identifier.outer"] = "v", -- identifiers usually charwise
            },
            include_surrounding_whitespace = true,
          },

          -- swap = {
          -- 	enable = true,
          -- 	swap_next = {
          -- 		["<leader>sp"] = "@parameter.inner", -- 's'wap 'p'arameter next
          -- 		["<leader>sf"] = "@function.outer", -- swap with next function (if applicable)
          -- 		["<leader>ss"] = "@statement.outer", -- swap with next statement (if applicable)
          -- 	},
          -- 	swap_previous = {
          -- 		["<leader>Sp"] = "@parameter.inner", -- 'S'wap 'p'arameter previous
          -- 		["<leader>Sf"] = "@function.outer", -- swap with previous function
          -- 		["<leader>Ss"] = "@statement.outer", -- swap with previous statement
          -- 	},
          -- },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]l"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
              ["]b"] = "@block.outer",
              ["]s"] = { query = "@statement.outer", desc = "Next statement start" },
              ["]a"] = "@assignment.outer",
              ["]p"] = "@parameter.outer",
            },
            goto_next_end = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[l"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
              ["[b"] = "@block.outer",
              ["[s"] = "@statement.outer",
              ["[a"] = "@assignment.outer",
              ["[p"] = "@parameter.outer",
              ["[t"] = "@tag.outer",
            },
            goto_previous_start = {
              ["[[f"] = "@function.outer",
              ["[[c"] = "@class.outer",
              ["[[l"] = "@loop.outer",
              ["[[i"] = "@conditional.outer",
              ["[[b"] = "@block.outer",
              ["[[s"] = "@statement.outer",
              ["[[a"] = "@assignment.outer",
              ["[[p"] = "@parameter.outer",
              ["[[t"] = "@tag.outer",
            },
            goto_previous_end = {
              ["[]f"] = "@function.outer",
              ["[]c"] = "@class.outer",
              ["[]l"] = "@loop.outer",
              ["[]i"] = "@conditional.outer",
              ["[]b"] = "@block.outer",
              ["[]s"] = "@statement.outer",
              ["[]a"] = "@assignment.outer",
              ["[]p"] = "@parameter.outer",
              ["[]t"] = "@tag.outer",
            },
          },
        },
      }
    end,
  },
  -- mini.ai
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  -- mini move
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",

        -- Move current line in Normal mode
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    cmd = { "NvimTreeToggle" },
    opts = function()
      dofile(vim.g.base46_cache .. "nvimtree")

      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "-", { buffer = bufnr })
        vim.keymap.set("n", "<C-m>", "<Nop>", opts "Disabled")
        -- custom mappings
        vim.keymap.set("n", "w", api.tree.change_root_to_parent, opts "Up")

        vim.keymap.set("n", "e", api.tree.change_root_to_node, opts "Down")
        vim.keymap.set("n", "h", function()
          api.node.navigate.parent_close()
        end, opts "Close Directory")

        vim.keymap.set("n", "l", function()
          api.node.open.edit()
        end, opts "Open Directory")

        vim.keymap.set("n", "i", function()
          api.live_filter.start()
        end, opts "Filter")

        vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
      end

      return {
        on_attach = my_on_attach,
        filters = { dotfiles = false },
        disable_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          side = "left",
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              default = "󰈚",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
              },
              git = { unmerged = "" },
            },
          },
        },
      }
    end,
  },

  -- persist session
  {
    "folke/persistence.nvim",
    lazy = true,
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>q", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    },
  },

  --trouble nvim
  {
    "folke/trouble.nvim",
    enabled = true,
    lazy = true,
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      -- { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      -- { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      jump = {
        autojump = true, -- Automatically jump when there's only one match
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- @type false | "classic" | "modern" | "helix"
      preset = "helix",

      win = {
        border = "none",
      },
      spec = {
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
        { "<leader>b", group = "Buffers" }, -- group
        { "<leader>c", group = "Code" }, -- group
        { "<leader>f", group = "Find" }, -- group
        { "<leader>s", group = "Search" }, -- group
        { "<leader>l", group = "Linter" }, -- group
        { "<leader>o", group = "Obsidian" }, -- group
        { "<leader>t", group = "Toggles and Trouble" }, -- group
      },
    },

    keys = {},
  },
}
