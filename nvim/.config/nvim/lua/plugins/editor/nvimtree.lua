local map = vim.keymap.set
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	cmd = { "NvimTreeToggle" },
	opts = function()
		dofile(vim.g.base46_cache .. "nvimtree")

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "w", api.tree.change_root_to_parent, opts("Up"))

			vim.keymap.set("n", "e", api.tree.change_root_to_node, opts("Down"))
			vim.keymap.set("n", "h", function()
				api.node.navigate.parent_close()
			end, opts("Close Directory"))

			vim.keymap.set("n", "l", function()
				api.node.open.edit()
			end, opts("Open Directory"))

			vim.keymap.set("n", "i", function()
				api.live_filter.start()
			end, opts("Filter"))

			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end

		return {
			on_attach = my_on_attach,
			filters = { dotfiles = false },
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				side = "left",
				width = 30,
				preserve_window_proportions = true,
			},
			renderer = {
				root_folder_label = false,
				highlight_git = true,
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						default = "󰈚",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
						},
						git = { unmerged = "" },
					},
				},
			},
		}
	end,

	-- config = function(_, opts)
	-- 	-- pass to setup along with your other options
	-- 	require("nvim-tree").setup({
	-- 		---
	-- 		opts,
	-- 		---
	-- 	})
	-- end,
}
