return {
	-- plenary , volt , menu
	{
		"nvim-lua/plenary.nvim",
		"nvchad/volt",
		"nvchad/menu",
	},

	-- base46
	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	-- nvchad ui
	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},

	-- minty
	{ "nvchad/minty", cmd = { "Huefy", "Shades" } },

	--web-devicons
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},

	-- rainbow csv
	{
		"cameron-wags/rainbow_csv.nvim",
		lazy = true,
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},
}
