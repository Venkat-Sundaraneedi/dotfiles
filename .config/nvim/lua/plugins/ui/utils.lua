---@diagnostic disable: missing-parameter
return {
	{ "MunifTanjim/nui.nvim" },

	-- maximizer
	{
		"szw/vim-maximizer",
		lazy = false,
	},

	-- inc-rename
	{
		"smjonas/inc-rename.nvim",
		lazy = true,
		cmd = "IncRename",
		opts = {},
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
	-- dicitionary
	{
		"uga-rosa/cmp-dictionary",
		lazy = true,
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					txt = { "/usr/share/dict/words/dictionary.txt" },
					-- comments = { "/usr/share/dict/words/dictionary.txt" },
				},
				exact_length = 2,
				max_number_items = 4, -- Limits suggestions to 4 items
				async = true, -- Asynchronous dictionary loading
			})

			require("cmp_dictionary").setup({
				paths = { "/usr/share/dict/words/dictionary.txt" },
				exact_length = 2,
				async = true, -- Enable asynchronous loading
			})
		end,
	},

	-- todo comments
	-- TODO:
	-- HACK:
	-- WARN:
	-- PERF:
	-- NOTE:
	-- TEST:
	-- BUG:
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			{
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info", alt = {} },
					HACK = { icon = " ", color = "warning", alt = { "hack" } },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
			},
		},
	},
}
