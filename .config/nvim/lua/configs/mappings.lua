local map = vim.keymap.set

--------------------------------------------------------------------------------------------------------------------------------------------

-- NOMAP KEYS
map("n", "za", "<Nop>")
map("n", "zA", "<Nop>")
map("n", "zb", "<Nop>")
map("n", "zc", "<Nop>")
map("n", "zC", "<Nop>")
map("n", "zd", "<Nop>")
map("n", "zD", "<Nop>")
map("n", "ze", "<Nop>")
map("n", "zE", "<Nop>")
map("n", "zf", "<Nop>")
map("n", "zg", "<Nop>")
map("n", "zh", "<Nop>")
map("n", "zH", "<Nop>")
map("n", "zi", "<Nop>")
map("n", "zL", "<Nop>")
map("n", "zm", "<Nop>")
map("n", "zM", "<Nop>")
map("n", "zo", "<Nop>")
map("n", "zO", "<Nop>")
map("n", "zr", "<Nop>")
map("n", "zR", "<Nop>")
map("n", "zs", "<Nop>")
map("n", "zt", "<Nop>")
map("n", "zv", "<Nop>")
map("n", "zw", "<Nop>")
map("n", "zx", "<Nop>")
map("n", "zz", "<Nop>")
map("n", "z<CR>", "<Nop>")
map("n", "z=", "<Nop>")

map("n", "f", "<Nop>")
map("n", "F", "<Nop>")
map("n", "t", "<Nop>")
map("n", "T", "<Nop>")
map("n", "M", "<Nop>")
map("n", "!", "<Nop>")
map("n", ",", "<Nop>")
map("n", "<", "<Nop>")
map("n", ">", "<Nop>")
map("n", "`", "<Nop>")
map("n", "?", "<Nop>")
map("n", "{", "<Nop>")
map("n", "}", "<Nop>")
map("n", "~", "<Nop>")
map("n", '"', "<Nop>")
map("n", "'", "<Nop>")
map("n", "g~", "<Nop>")
map("n", "gu", "<Nop>")
map("n", "gU", "<Nop>")
map("n", "gv", "<Nop>")
map("n", "gw", "<Nop>")
map("n", "g%", "<Nop>")
map("n", "g[", "<Nop>")
map("n", "g]", "<Nop>")
map("n", "g`", "<Nop>")
map("n", "g'", "<Nop>")
map("n", "gn", "<Nop>")
map("n", "gx", "<Nop>")
map("n", "gf", "<Nop>")
map("n", "gN", "<Nop>")
map("n", "gt", "<Nop>")
map("n", "gT", "<Nop>")
map("n", "[m", "<Nop>")
map("n", "[M", "<Nop>")
map("n", "[s", "<Nop>")
map("n", "[%", "<Nop>")
map("n", "]m", "<Nop>")
map("n", "]M", "<Nop>")
map("n", "]s", "<Nop>")
map("n", "]%", "<Nop>")
map("n", "[(", "<Nop>")
map("n", "[}", "<Nop>")
map("n", "](", "<Nop>")
map("n", "]}", "<Nop>")
map("n", "]<", "<Nop>")
map("n", "]<", "<Nop>")
map("n", "K", "<Nop>")
map("n", "[d", "<Nop>")
map("n", "]d", "<Nop>")
map("n", "]]", "<Nop>")
map("n", "][", "<Nop>")
map("n", "[]", "<Nop>")
map("n", "[[", "<Nop>")
map("n", "/", "<Nop>")

-- Swap v and V for visual modes
map("n", "<A-v>", "V", { noremap = true })

map("n", "<leader>gf", "gf", { desc = "Go to file under cursor", noremap = true })
map("n", "<leader>gx", "gx", { desc = "Go to url", noremap = true })

map("n", "gpfs", "[m", { desc = "Go to previous function start", noremap = true })
map("n", "gpfe", "[M", { desc = "Go to previous function end", noremap = true })

map("n", "gnfs", "]m", { desc = "Go to next function start", noremap = true })
map("n", "gnfe", "]M", { desc = "Go to next  function end", noremap = true })

map("n", "gpb", "[(", { desc = "Go to previous (", noremap = true })
map("n", "gpcb", "[{", { desc = "Go to previous {", noremap = true })

map("n", "gnb", "](", { desc = "Go to next (", noremap = true })
map("n", "gncb", "]{", { desc = "Go to next {", noremap = true })
map("n", "<leader><space>", "/", { noremap = true })

-- Map gj to go to the end of the file
map({ "n", "v" }, "ga", "G", { desc = "Go to bottom line", noremap = true })

-- comment
map("n", "<leader>;", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>;", "gc", { desc = "comment toggle", remap = true })

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
map({ "i", "c" }, "JK", "<cmd>noh<CR><ESC>")
map({ "n", "i", "c" }, "<ESC>", "<cmd>noh<CR><ESC>")
map("v", "u", "<cmd>noh<CR><ESC>")

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
map("n", "<A-k>", "<c-w>k", { desc = "switch window up" })
map("n", "<A-j>", "<C-w>j", { desc = "switch window down" })

-- format
map("n", "<leader>fa", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>n", ":enew<CR>", { noremap = true, silent = true })

-- Telescope diagnostics (requires telescope.nvim and telescope-lsp-handlers.nvim)
map("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" })
