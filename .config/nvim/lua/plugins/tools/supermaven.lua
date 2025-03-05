return {
	"supermaven-inc/supermaven-nvim",
	lazy = false,
	config = function()
		require("supermaven-nvim").setup({
			-- keymaps
			keymaps = {
				accept_suggestion = "<C-u>",
				-- clear_suggestion = "<leader>n",
				-- accept_word = "<leader>a",
			},

			ignore_filetypes = {},
			color = {
				suggestion_color = "#ffffff",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false,
			disable_keymaps = false,
		})
	end,
}
