return {
	"NvChad/nvterm",
	config = function()
		local nvterm = require("nvterm.terminal")

		function _G.toggle_terminal_with_tabs_or_buffers()
			nvterm.toggle("horizontal")
			vim.cmd("buffers")
		end

		require("nvterm").setup({
			terminals = {
				shell = vim.o.shell,
				list = {},
				type_opts = {
					float = {
						relative = "editor",
						row = 0.3,
						col = 0.25,
						width = 0.5,
						height = 0.4,
						border = "single",
					},
					horizontal = { location = "rightbelow", split_ratio = 0.4 },
					vertical = { location = "rightbelow", split_ratio = 0.5 },
				},
			},
			behavior = {
				autoclose_on_quit = {
					enabled = false,
					confirm = true,
				},
				close_on_exit = true,
				auto_insert = false,
			},
		})
	end,
}
