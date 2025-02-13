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

			outline_window = {
				auto_close = true,
				auto_jump = true,
				focus_on_open = true,
			},
			preview_window = {
				winhl = "NormalFloat:",
			},
			outline_items = {
				auto_set_cursor = true, -- This will make the outline window follow your cursor in code
			},
			-- Your setup opts here
			keymaps = {
				fold_toggle_all = "<S-Tab>",
				up_and_jump = "<up>",
				down_and_jump = "<down>",
				-- goto_location = "v", -- Press Enter to jump without closing the window
				-- goto_location = "<>",
			},
		},
	},
}
