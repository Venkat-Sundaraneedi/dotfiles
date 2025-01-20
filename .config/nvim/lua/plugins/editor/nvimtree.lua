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
				--     centralize_selection = false,
				--     cursorline = true,
				--     debounce_delay = 15,
				side = "right",
				-- preserve_window_proportions = true,
				--     number = false,
				--     relativenumber = false,
				--     signcolumn = "yes",
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
				--     add_trailing = false,
				--     group_empty = false,
				full_name = true,
				root_folder_label = false, -- false ":~:s?$?/..?"
				indent_width = 2,
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				--     hidden_display = "none",
				--     symlink_destination = true,
				highlight_git = true, -- "none"
				--     highlight_diagnostics = "none",
				--     highlight_opened_files = "none",
				--     highlight_modified = "none",
				--     highlight_hidden = "none",
				--     highlight_bookmarks = "none",
				--     highlight_clipboard = "name",
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
					--       git_placement = "before",
					--       modified_placement = "after",
					--       hidden_placement = "after",
					--       diagnostics_placement = "signcolumn",
					--       bookmarks_placement = "signcolumn",
					--       padding = " ",
					--       symlink_arrow = " ➛ ",
					--       show = {
					--         file = true,
					--         folder = true,
					--         folder_arrow = true,
					--         git = true,
					--         modified = true,
					--         hidden = false,
					--         diagnostics = true,
					--         bookmarks = true,
					--       },
					glyphs = {
						--
						default = "󰈚",
						--         default = "",
						--         symlink = "",
						--         bookmark = "󰆤",
						--         modified = "●",
						--         hidden = "󰜌",
						folder = {
							--
							default = "",
							empty = "",
							empty_open = "",
							-- empty_open = "",
							open = "",
							-- open = "",
							symlink = "",
							symlink_open = "",
							-- symlink = "",
							arrow_closed = "",
							arrow_open = "",
						},
						git = {
							-- unstaged = "✗",
							-- staged = "✓",
							unmerged = "",
							-- renamed = "➜",
							untracked = "★",
							-- deleted = "",
							-- ignored = "◌",
						},
					},
				},
			},
		},
	},
}
