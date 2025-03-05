local actions = require("telescope.actions")
dofile(vim.g.base46_cache .. "telescope")
local map = vim.keymap.set

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "keymaps" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })

return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{
				"nvim-telescope/telescope-ui-select.nvim",
				lazy = true,
			},
		},
		cmd = "Telescope",

		config = function()
			local telescope = require("telescope")

			telescope.setup({

				defaults = {
					prompt_prefix = "   ",
					selection_caret = " ",
					entry_prefix = " ",
					sorting_strategy = "descending",
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
							preview_width = 0.45,
						},
						width = 0.80,
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
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
