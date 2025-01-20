return {
	--  outline
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>ko", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
			keymaps = {
				up_and_jump = "<up>",
				down_and_jump = "<down>",
				-- goto_location = "<>",
			},
		},
	},
}
