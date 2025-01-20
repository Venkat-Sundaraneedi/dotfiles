local autocmd = vim.api.nvim_create_autocmd

autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "term://*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)

		if not string.find(bufname, "lazygit") then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true), "n", true)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
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

autocmd({ "BufLeave", "TermClose" }, {
	pattern = "term://*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)

		if string.find(bufname, "lazygit") then
			vim.api.nvim_buf_set_keymap(0, "t", "jk", "<Esc>", { noremap = true, silent = true })
		end
	end,
})

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
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

-- autocmd to set the cursor to the last line of the file
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
