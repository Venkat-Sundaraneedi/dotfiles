local actions = require("telescope.actions")
dofile(vim.g.base46_cache .. "telescope")
local map = vim.keymap.set

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
-- map(
-- 	"n",
-- 	"<leader>fb",
-- 	"<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
-- 	{ desc = "telescope find buffers" }
-- )
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "keymaps" })
map("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>so", "<cmd>Telescope vim_options<CR>", { desc = "Options" })

-- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

-- map(
-- 	"n",
-- 	"<leader>fa",
-- 	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
-- 	{ desc = "telescope find all files" }
-- )

return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		opts = {
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					i = { -- Insert mode mappings
						["<A-h>"] = actions.move_selection_previous,
						["<A-j>"] = actions.move_selection_next,
						["<A-k>"] = actions.move_selection_previous,
						["<A-l>"] = actions.move_selection_next,
					},
					n = { -- Normal mode mappings
						["<A-h>"] = actions.move_selection_previous,
						["<A-j>"] = actions.move_selection_next,
						["<A-k>"] = actions.move_selection_previous,
						["<A-l>"] = actions.move_selection_next,
						["q"] = actions.close,
					},
				},
			},

			extensions_list = { "themes", "terms" },
			extensions = {},
		},
	},
}
