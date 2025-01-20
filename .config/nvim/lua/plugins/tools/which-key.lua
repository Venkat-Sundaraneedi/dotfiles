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
			{ "<leader>q", group = "sessions" }, -- group
			{ "<leader>s", group = "search" }, -- group
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
		})
	end,
}
