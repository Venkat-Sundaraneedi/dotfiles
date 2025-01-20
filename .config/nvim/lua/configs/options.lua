local opt = vim.opt
local o = vim.o
local g = vim.g

------------------------------------ globals -----------------------------------------
g.autoformat = true

vim.opt.shell = "/bin/zsh"
------------------------------------ options ------------------------------------------
-- code folding
o.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
o.foldlevelstart = 99

o.laststatus = 0
o.cmdheight = 1
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 2
o.scrolloff = 28 -- Lines of context
o.list = false

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false
o.relativenumber = true

-- disable nvim intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 300
-- o.timeoutlen = g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 300

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
