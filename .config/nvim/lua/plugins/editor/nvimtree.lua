dofile(vim.g.base46_cache .. "nvimtree")
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Folder"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open Folder"))

	-- Move root directory up and down with the selected node
	vim.keymap.set("n", "q", function()
		local node = api.tree.get_node_under_cursor()
		if node then
			api.tree.change_root_to_parent(node)
			-- api.tree.reload() -- Refresh the tree to reflect the new root
		end
	end, opts("Move Root Up"))

	vim.keymap.set("n", "e", function()
		local node = api.tree.get_node_under_cursor()
		if node and node.type == "directory" then
			api.tree.change_root_to_node(node)
			vim.cmd("cd " .. node.absolute_path) -- Update Neovim's cwd
			-- api.tree.reload() -- Refresh the tree to reflect the new root
		end
	end, opts("Move Root Down"))

	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {

	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		lazy = false,
		keys = {
			{
				"<leader>e",
				"<cmd>NvimTreeToggle<cr>",
				desc = "NvimTree",
			},
		},

		opts = {
			on_attach = my_on_attach,
			filters = { dotfiles = false },
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = false,
				update_root = false,
			},
			view = {
				side = "right",
				width = 30,
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 40,
						row = 1,
						col = 1,
					},
				},
			},
			renderer = {
				full_name = true,
				root_folder_label = false, -- false ":~:s?$?/..?"
				indent_width = 2,
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				highlight_git = true, -- "none"
				indent_markers = {
					enable = false,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},
					glyphs = {
						--
						default = "󰈚",
						folder = {
							--
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_closed = "",
							arrow_open = "",
						},
						git = {
							unmerged = "",
							untracked = "★",
						},
					},
				},
			},
		},
	},
}
