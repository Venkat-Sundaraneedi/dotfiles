local map = vim.keymap.set

-------------------------------------------------------------------------------------------------------------------

-- Swap v and V for visual modes
map("n", "<A-v>", "V", { noremap = true })

-- Map ga to go to the end of the file
map({ "n", "v" }, "ga", "G", { desc = "Go to bottom line", noremap = true })

-- comment
map("n", "<leader>;", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>;", "gc", { desc = "comment toggle", remap = true })

-- pairing of brackets
map({ "n", "x", "s" }, "<a-e>", "%", { noremap = true, silent = true })

-- copy whole file
map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "file copy whole" })

-- enter the command mode
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ";;", ":! ", { desc = "CMD enter command mode" })

-- shortcut for escape
map({ "i", "c" }, "jk", "<cmd>noh<CR><ESC>")
map({ "n", "i", "c" }, "<ESC>", "<cmd>noh<CR><ESC>")
map("v", "u", "<cmd>noh<CR><ESC>")

-- terminal
map("t", "jk", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- write and exit commands
map({ "n", "v" }, ";e", "<cmd> wqa <cr>")
map({ "n", "v" }, ";n", "<cmd> qa! <cr>")

-- move to beginning and end of line in normal and insert mode
map({ "n", "v", "o" }, "<S-h>", "^", { desc = "move beginning of line" })
map({ "n", "v", "o" }, "<S-l>", "g_", { desc = "move end of line" })

--remap of arrow keys
-- map({ "i" }, "<A-h>", "<Left>", { desc = "move left" })
-- map({ "i" }, "<A-l>", "<Right>", { desc = "move right" })
-- map({ "i" }, "<A-j>", "<Down>", { desc = "move down" })
-- map({ "i" }, "<A-k>", "<Up>", { desc = "move up" })

--navigating windows
map("n", "<A-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<A-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<A-k>", "<c-w>k", { desc = "switch window up" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })

-- Toggle
map("n", "<leader>td", function()
	local is_enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not is_enabled)
	if not is_enabled then
		vim.notify("Diagnostics enabled", vim.log.levels.INFO)
	else
		vim.notify("Diagnostics disabled", vim.log.levels.INFO)
	end
end, { desc = "Toggle diagnostics" })

----------------------------------------------------------------------------------------------------------------------
---   USES NVCHAD APIS (NOT NATIVE TO NEOVIM)

-- Buffers
map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "Buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "Buffer goto prev" })

map("n", "<leader>bd", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "[B]uffer [D]elete" })

map("n", "<leader>bo", function()
	require("nvchad.tabufline").closeAllBufs(false) -- excludes current buf
end, { desc = "Delete other buffers" })

map("n", "<leader>bn", function()
	require("nvchad.tabufline").move_buf(1)
end, { desc = "Move buffer right" })

map("n", "<leader>bp", function()
	require("nvchad.tabufline").move_buf(-1)
end, { desc = "Move buffer left" })

-- Theme
map("n", "<leader>tt", function()
	require("nvchad.themes").open()
end, { desc = "Nvchad themes list" })
