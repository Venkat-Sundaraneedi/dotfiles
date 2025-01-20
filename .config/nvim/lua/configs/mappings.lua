local map = vim.keymap.set
-- local nomap = vim.keymap.del

--------------------------------------------------------------------------------------------------------------------------------------------

-- map({ "n", "t" }, "<A-i>", function()
-- 	require("nvterm.terminal").toggle("horizontal")
-- end, { desc = "horizontal terminal" })

-- comment
map("n", "<leader>;", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>;", "gc", { desc = "comment toggle", remap = true })

-- LazyGit
map("n", "<leader>gl", "<cmd>LazyGit<cr>")

-- Keymap to toggle maximization of the current window
map("n", "<a-m>", ":MaximizerToggle<CR>", { noremap = true, silent = true })

-- pairing of brackets
map({ "n", "x", "s" }, "<a-e>", "%", { noremap = true, silent = true })

-- copy whole file
map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "file copy whole" })

-- enter the command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- shortcut for escape
map({ "i", "c" }, "jk", "<cmd>noh<CR><ESC>")
map({ "n", "i", "c" }, "<ESC>", "<cmd>noh<CR><ESC>")

-- terminal
map("t", "jk", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- write and exit commands
map({ "n", "v" }, ";e", "<cmd> wqa <cr>")
map({ "n", "v" }, ";n", "<cmd> qa! <cr>")

-- move to beginning and end of line in normal and insert mode
map("n", "<S-h>", "^", { desc = "move beginning of line" })
map("n", "<S-l>", "$", { desc = "move end of line" })
map("i", "fh", "<ESC>^i", { desc = "move beginning of line" })
map("i", "fl", "<End>", { desc = "move end of line" })

--remap of arrow keys
map({ "i", "t" }, "<A-h>", "<Left>", { desc = "move left" })
map({ "i", "t" }, "<A-l>", "<Right>", { desc = "move right" })
map({ "i", "t" }, "<A-j>", "<Down>", { desc = "move down" })
map({ "i", "t" }, "<A-k>", "<Up>", { desc = "move up" })

--navigating windows
map("n", "<A-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<A-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<A-k>", "<c-w>k", { desc = "switch window up" })

-- NVCHAD mappings
-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- format
map("n", "<leader>fa", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- buffer/tabs
map("n", "<leader>tn", ":tabnew<cr>", { desc = "opens tabpage after the current one" })
map("n", "<leader>ts", ":tab split<cr>", { desc = "opens current buffer in new tab page" })
map("n", "<leader>tc", ":tabclose<cr>", { desc = "close the current tab page" })
map("n", "<leader>to", ":tabonly<cr>", { desc = "close all tab pages except the current one" })
map("n", "<leader>tk", ":+tabnext<cr>", { desc = "go to the next tab page" })
map("n", "<leader>tj", ":-tabnext<cr>", { desc = "go to the previous tab page" })
map("n", "<leader>tmk", ":-tabmove<cr>", { desc = "move the tab page to the right" })
map("n", "<leader>tmj", ":-tabmove<cr>", { desc = "move the tab page to the left" })

map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- buffers
map("n", "<leader>bd", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "buffer delete" })
vim.keymap.set("n", "<leader>bo", function()
	require("nvchad.tabufline").closeAllBufs(false) -- excludes current buf
end, { desc = "Delete other buffers " })

-- themes
vim.api.nvim_create_user_command("Nvthemes", function()
	require("nvchad.themes").open()
end, { desc = "Open NvChad themes with Telescope" })

-- Keybinding to toggle nvim-cmp
map("n", "<leader>i", function()
	ToggleCmp()
end, { desc = "Toggle nvim-cmp", noremap = true, silent = true })

local cmp = require("cmp")
local cmp_enabled = true

local api = require("supermaven-nvim.api")

_G.ToggleCmp = function()
	cmp_enabled = not cmp_enabled
	if cmp_enabled then
		api.stop()
		vim.notify("nvim-cmp Enabled and supermaven Disabled", vim.log.levels.INFO)
	else
		api.start()
		vim.notify("nvim-cmp Disabled and supermaven Enabled", vim.log.levels.WARN)
	end
end

cmp.setup({
	enabled = function()
		return cmp_enabled
	end,
})

-- vim.keymap.set("n", "<leader>mt", api.toggle, { noremap = true, silent = true, desc = "Toggle supermaven-nvim" })
