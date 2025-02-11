-- which-key
return {
	"folke/which-key.nvim",
	lazy = false,
	keys = {
		"<leader>",
		"<c-w>",
		'"',
		"'",
		"`",
		"c",
		"v",
		"g",
	},
	cmd = "WhichKey",
	opts = function()
		-- dofile(vim.g.base46_cache .. "whichkey")
		return {}
	end,

	config = function()
		dofile(vim.g.base46_cache .. "whichkey")
		local wk = require("which-key")
		wk.add({
			{ "<leader>f", group = "file" }, -- group
			{ "<leader>t", group = "tabs" }, -- group
			{ "<leader>k", group = "toggles" }, -- group
			{ "<leader>x", group = "trouble" }, -- group
			-- { "<leader>q", group = "sessions" }, -- group
			{ "<leader>s", group = "search" }, -- group
			{ "gi", group = "goto" }, -- group
			{ "gp", group = "previous" }, -- group
			{ "gn", group = "next" }, -- group
			{ "<leader>g", group = "goto" }, -- group
			{ "<leader>b", group = "buffer" }, -- group
			{ "<leader>c", group = "code" }, -- group
			-- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
			-- {
			-- 	"<leader>fb",
			-- 	function()
			-- 		print("hello")
			-- 	end,
			-- 	desc = "Foobar",
			-- },
			-- { "<leader>fn", desc = "New File" },
			{ "<leader><space>", desc = "Search" },
			-- { "<leader>f1", hidden = true }, -- hide this keymap
			{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
			{
				"<leader>b",
				group = "buffers",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				-- Nested mappings are allowed and can be added in any order
				-- Most attributes can be inherited or overridden on any level
				-- There's no limit to the depth of nesting
				mode = { "n", "v" }, -- NORMAL and VISUAL mode
				-- { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
				-- { "<leader>w", "<cmd>w<cr>", desc = "Write" },
			},

			-- REMOVED KEYMAPS
			{ "za", hidden = true },
			{ "zA", hidden = true },
			{ "zb", hidden = true },
			{ "zc", hidden = true },
			{ "zC", hidden = true },
			{ "zd", hidden = true },
			{ "zD", hidden = true },
			{ "ze", hidden = true },
			{ "zE", hidden = true },
			{ "zf", hidden = true },
			{ "zg", hidden = true },
			{ "zh", hidden = true },
			{ "zH", hidden = true },
			{ "zi", hidden = true },
			{ "zL", hidden = true },
			{ "zm", hidden = true },
			{ "zM", hidden = true },
			{ "zo", hidden = true },
			{ "zO", hidden = true },
			{ "zr", hidden = true },
			{ "zR", hidden = true },
			{ "zs", hidden = true },
			{ "zt", hidden = true },
			{ "zv", hidden = true },
			{ "zw", hidden = true },
			{ "zx", hidden = true },
			{ "zz", hidden = true },
			{ "z<CR>", hidden = true },
			{ "z=", hidden = true },
			{ "f", hidden = true },
			{ "F", hidden = true },
			{ "t", hidden = true },
			{ "T", hidden = true },
			{ "M", hidden = true },
			{ "!", hidden = true },
			{ ",", hidden = true },
			{ "`", hidden = true },
			{ "<", hidden = true },
			{ ">", hidden = true },
			{ "?", hidden = true },
			{ "{", hidden = true },
			{ "}", hidden = true },
			{ "~", hidden = true },
			{ "q", hidden = true },
			{ '"', hidden = true },
			{ "'", hidden = true },
			{ "g~", hidden = true },
			{ "gu", hidden = true },
			{ "gU", hidden = true },
			{ "gf", hidden = true },
			{ "gx", hidden = true },
			{ "gv", hidden = true },
			{ "gw", hidden = true },
			{ "g%", hidden = true },
			{ "g[", hidden = true },
			{ "g]", hidden = true },
			{ "g`", hidden = true },
			{ "g'", hidden = true },
			-- { "gn", hidden = true },
			{ "gN", hidden = true },
			{ "gt", hidden = true },
			{ "gT", hidden = true },
			{ "[s", hidden = true },
			{ "[m", hidden = true },
			{ "[M", hidden = true },
			{ "[%", hidden = true },
			{ "]s", hidden = true },
			{ "]m", hidden = true },
			{ "]M", hidden = true },
			{ "]%", hidden = true },
			{ "[(", hidden = true },
			{ "[{", hidden = true },
			{ "](", hidden = true },
			{ "]{", hidden = true },
			{ "[}", hidden = true },
			{ "]}", hidden = true },
			{ "]<", hidden = true },
			{ "[<", hidden = true },
			{ "K", hidden = true },
			{ "[d", hidden = true },
			{ "]d", hidden = true },
			{ "]]", hidden = true },
			{ "[[", hidden = true },
			{ "][", hidden = true },
			{ "[]", hidden = true },
			{ "/", hidden = true },

			-- HIDDEN
			{ "<leader>e", hidden = true },
			{ "<leader>q", hidden = true },
			{ "<leader>;", hidden = true },
			{ "v", hidden = true },
			{ "V", hidden = true },
			{ "0", hidden = true },
			{ "b", hidden = true },
			{ "B", hidden = true },
			{ "c", hidden = true },
			{ "d", hidden = true },
			{ "e", hidden = true },
			{ "E", hidden = true },
			{ "G", hidden = true },
			{ "h", hidden = true },
			{ "H", hidden = true },
			{ "j", hidden = true },
			{ "k", hidden = true },
			{ "l", hidden = true },
			{ "L", hidden = true },
			{ "r", hidden = true },
			{ "s", hidden = true },
			{ "w", hidden = true },
			{ "W", hidden = true },
			{ "y", hidden = true },
			{ "Y", hidden = true },
			{ "$", hidden = true },
			{ "%", hidden = true },
			{ "^", hidden = true },
			{ "&", hidden = true },
			{ "<C-c>", hidden = true },
			{ "<C-h>", hidden = true },
			{ "<C-j>", hidden = true },
			{ "<C-k>", hidden = true },
			{ "<C-l>", hidden = true },
			{ "<C-w>", hidden = true },
			{ "<A-e>", hidden = true },
			{ "<A-h>", hidden = true },
			{ "<A-j>", hidden = true },
			{ "<A-k>", hidden = true },
			{ "<A-l>", hidden = true },
			{ "<A-m>", hidden = true },
			{ "<A-v>", hidden = true },
			{ "<tab>", hidden = true },
			{ "<S-tab>", hidden = true },
			{ ";", hidden = true },
			{ "<F3>", hidden = true },
			{ "<Esc>", hidden = true },
			{ "/", hidden = true },
			{ "gc", hidden = true },
		})
	end,
}
