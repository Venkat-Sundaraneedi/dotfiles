---@diagnostic disable: missing-parameter
-- Keymap to toggle maximization of the current window
local map = vim.keymap.set

-- inc-rename
map("n", "<leader>cr", function()
	local inc_rename = require("inc_rename")
	return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename with inc_rename", silent = true })

return {
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},

	-- inc-rename
	{
		"smjonas/inc-rename.nvim",
		lazy = false,
		cmd = "IncRename",
		opts = {},
		config = function() end,
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

	-- todo comments
	-- TODO:
	-- HACK:
	-- WARN:
	-- PERF:
	-- NOTE:
	-- TEST:
	-- BUG:
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			{
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info", alt = {} },
					HACK = { icon = " ", color = "warning", alt = { "hack" } },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
			},
		},
	},
}
