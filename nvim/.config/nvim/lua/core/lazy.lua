local base46_cache = vim.fn.stdpath("data") .. "/base46/"
if not vim.uv.fs_stat(base46_cache) then
	vim.fn.system({ "mkdir", "-p", base46_cache })
end
vim.g.base46_cache = base46_cache

vim.g.maplocalleader = " "

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		priority = 1000, -- Load this first
		import = "nvchad.plugins",
	},

	{ import = "plugins.init" },

	defaults = { lazy = true },
	install = { colorscheme = { "nvchad" } },

	ui = {
		icons = vim.g.have_nerd_font and {} or {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- Reset packpath to improve startup time
		rtp = {
			reset = true,
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Add error handling for your config loads
local function safe_require(module)
	local success, err = pcall(require, module)
	if not success then
		vim.notify("Error loading " .. module .. "\n" .. err, vim.log.levels.ERROR)
	end
end

safe_require("core.lsp")
safe_require("configs.options")
safe_require("configs.autocmds")
safe_require("configs.filetypes")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("configs.mappings")
	end,
})

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"move_analyzer",
	"denols",
	"marksman",
	"solidity_ls_nomicfoundation",
})
