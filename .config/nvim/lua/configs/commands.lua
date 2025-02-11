local cmd = vim.api.nvim_create_user_command
-- themes
cmd("Nvthemes", function()
	require("nvchad.themes").open()
end, { desc = "Open NvChad themes with Telescope" })

-- cmd("Ff", function()
-- 	require("nvim-tree.api").tree.open()
-- end, { desc = "Open NvChad themes with Telescope" })
