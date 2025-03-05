local cmd = vim.api.nvim_create_user_command
-- themes
cmd("Nvthemes", function()
	require("nvchad.themes").open()
end, { desc = "Open NvChad themes with Telescope" })

-- Function to toggle nvim-cmp
cmd("Cmpt", function()
	ToggleCmp()
end, { desc = "Toggle nvim-cmp" })

-- neotree toggle
cmd("Tt", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Toggle neo-tree" })

local cmp = require("cmp")
local cmp_enabled = true

_G.ToggleCmp = function()
	cmp_enabled = not cmp_enabled
	if cmp_enabled then
		vim.notify("nvim-cmp Enabled ", vim.log.levels.INFO)
	else
		vim.notify("nvim-cmp Disabled ", vim.log.levels.WARN)
	end
end

cmp.setup({
	enabled = function()
		return cmp_enabled
	end,
})
