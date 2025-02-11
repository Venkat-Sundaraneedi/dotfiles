---@diagnostic disable: missing-parameter
return {
	-- maximizer
	{
		"szw/vim-maximizer",
		lazy = true,
	},

	-- inc-rename
	{
		"smjonas/inc-rename.nvim",
		lazy = true,
		cmd = "IncRename",
		opts = {},
	},

	-- flash
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {
			jump = {
				autojump = true, -- Automatically jump when there's only one match
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	-- dicitionary
	{
		"uga-rosa/cmp-dictionary",
		lazy = true,
		enabled = true,
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					-- Define dictionaries for specific filetypes
					txt = { "/usr/share/dict/words/dictionary.txt" },
					-- comments = { "/usr/share/dict/words/dictionary.txt" },
				},
				exact_length = 2,
				max_number_items = 4, -- Limits suggestions to 4 items
				async = true, -- Asynchronous dictionary loading
			})

			require("cmp_dictionary").setup({
				paths = { "/usr/share/dict/words/dictionary.txt" },
				exact_length = 2,
				async = true, -- Enable asynchronous loading
			})
		end,
	},

	-- todo comments
	-- {
	--  keys = {
	--    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
	--    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
	--    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
	--    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
	--    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
	--    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
	--
	--      -- fzf
	--    { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
	--    { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
	--
	--  },
	-- },
	-- TODO:
	-- HACK:
	-- WARN:
	-- PERF:
	-- NOTE:
	-- TEST:
	{
		"folke/todo-comments.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			{
				signs = true, -- show icons in the signs column
				sign_priority = 8, -- sign priority
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
				gui_style = {
					fg = "NONE", -- The gui style to use for the fg highlight group.
					bg = "BOLD", -- The gui style to use for the bg highlight group.
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- highlighting of the line containing the todo comment
				-- * before: highlights before the keyword (typically comment characters)
				-- * keyword: highlights of the keyword
				-- * after: highlights after the keyword (todo text)
				highlight = {
					multiline = true, -- enable multine todo comments
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
					after = "fg", -- "fg" or "bg" or empty
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of named colors where we try to extract the guifg from the
				-- list of highlight groups or use the hex color if hl not found as a fallback
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
					info = { "DiagnosticInfo", "#2563EB" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					-- regex that will be used to match keywords.
					-- don't replace the (KEYWORDS) placeholder
					pattern = [[\b(KEYWORDS):]], -- ripgrep regex
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			},
		},

		--  keys = {
		--    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
		--    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
		--    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
		--    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		--    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		--    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		--
		--      -- fzf
		--    { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
		--    { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
		--
		--  },
	},
}
