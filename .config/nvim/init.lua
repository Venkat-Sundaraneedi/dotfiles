if vim.g.startup_profile then
	local startup_time = vim.fn.reltime()
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			print("Startup Time: " .. vim.fn.reltimestr(vim.fn.reltime(startup_time)) .. " seconds")
		end,
	})
end
require("configs.lazy")
