local autocmd = vim.api.nvim_create_autocmd

-- //========== autocmds ==========//

-- Autocommand to prevent reopening of specific buffers
vim.api.nvim_create_autocmd({ "BufLeave", "BufUnload", "BufDelete" }, {
	pattern = "*", -- Apply to all buffers
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- Check if the buffer name contains "health", "lspinfo", or "conforminfo"
		if string.find(bufname, "health") or string.find(bufname, "lspinfo") or string.find(bufname, "conforminfo") then
			-- Prevent the buffer from being listed (hidden from buffer list)
			vim.api.nvim_buf_set_option(bufnr, "buflisted", false)

			-- Optionally, clear the buffer contents to ensure it's truly gone
			-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
			-- This line is commented out because it might not be desirable in all cases.
			-- It completely clears the buffer's content.

			print("Preventing buffer from reopening: " .. bufname)
		end
	end,
})

-- nvdash on buffer close
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local bufs = vim.t.bufs
		if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
			vim.cmd("Nvdash")
		end
	end,
})
-- autocmd to be in normal mode when opening lazygit
autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "term://*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)

		if not string.find(bufname, "lazygit") then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true), "n", true)
		end
	end,
})

-- autocmd to set indentation and keymap for sway files
autocmd({ "FileType" }, {
	pattern = "sway",
	callback = function()
		-- Set indentation for Sway files
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true

		-- Optional: Add any Sway-specific key mappings
		vim.keymap.set("n", "<leader>fb", ":!forc build<CR>", { buffer = true })
	end,
})

-- autocmd to format on save
autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- autocmd to refresh json file when it changes
autocmd("FileChangedShell", {
	pattern = "*.json",
	command = "checktime",
})

-- autocmd to set the cursor to the last change of the file
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "[Prompt]",
	callback = function()
		require("cmp").setup({
			enabled = false,
		})
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "[Prompt]",
	callback = function()
		require("cmp").setup({
			enabled = true,
		})
	end,
})
