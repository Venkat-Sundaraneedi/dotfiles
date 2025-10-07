-- which-key
return {
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
				{ "<leader>b", group = "Buffers" },
				{ "<leader>c", group = "Code" },
				{ "<leader>f", group = "Find" },
				{ "<leader>s", group = "Search" },
				{ "<leader>l", group = "Linter" },
				{ "<leader>o", group = "Obsidian" },
				{ "<leader>t", group = "Toggles and Trouble" },
			},
		},

		keys = {},
	},
}
