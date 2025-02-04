---@diagnostic disable: missing-parameter
return {
	-- maximizer
	{
		"szw/vim-maximizer",
		lazy = false,
	},

	-- lazygit
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "User FilePost",
		opts = {
			signs = {
				delete = { text = "󰍵" },
				changedelete = { text = "󱕖" },
			},
		},
		config = function()
			dofile(vim.g.base46_cache .. "git")
		end,
	},

	-- inc-rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},

	-- flash
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {},
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
		enabled = false,
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					-- Define dictionaries for specific filetypes
					txt = { "/usr/share/dict/words/dictionary.txt" },
					comments = { "/usr/share/dict/words/dictionary.txt" },
				},
				async = true, -- Asynchronous dictionary loading
			})

			require("cmp_dictionary").setup({
				paths = { "/usr/share/dict/words.txt" },
				exact_length = 2,
				async = true, -- Enable asynchronous loading
			})
		end,
	},
}
