require "nvchad.options"


local opt = vim.opt
local o = vim.o
local g = vim.g

------------------------------------ globals -----------------------------------------
g.autoformat = true

opt.shell = "/usr/bin/fish"
------------------------------------ options ------------------------------------------
-- Lua
o.encoding = "utf-8"
o.fileencoding = "utf-8"

g.have_nerd_font = true

vim.diagnostic.enable(false)

vim.schedule(function()
	o.clipboard = "unnamedplus"
end)

o.breakindent = true
o.updatetime = 250

o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.autoindent = true -- Automatically indent new lines
o.smartindent = true
o.tabstop = 2
o.winborder = "solid"
-- bold, double, none, rounded,shadow,single,solid

o.softtabstop = 2
o.scrolloff = 28 -- Lines of context

o.list = false
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.fillchars = { eob = "~" }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 300
-- o.timeoutlen = g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
o.undofile = true

