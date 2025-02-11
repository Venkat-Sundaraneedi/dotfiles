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
			{
				outline_window = {
					auto_close = true,
					auto_jump = true,
				},
			},
			-- Your setup opts here
			keymaps = {
				fold_toggle_all = "<S-Tab>",
				up_and_jump = "<up>",
				down_and_jump = "<down>",
				-- goto_location = "<>",
			},
		},
	},
}
