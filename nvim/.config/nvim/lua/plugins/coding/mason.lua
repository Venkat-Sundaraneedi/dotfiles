return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		cmd = "Mason",
		-- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				-- LSP servers (matching your vim.lsp.enable() config)
				"lua-language-server", -- Lua LSP
				-- "gopls", -- Go LSP
				-- "zls", -- Zig LSP
				-- "typescript-language-server", -- TypeScript LSP
				"rust-analyzer", -- Rust LSP

				"move-analyzer", -- Move LSP

				-- Formatters (for conform.nvim and general use)
				"stylua",
				-- "goimports",
				-- Note: gofmt comes with Go installation, not managed by Mason
				-- "prettier",
				-- "black",
				-- "isort",

				-- Linters and diagnostics
				-- "golangci-lint",
				-- "eslint_d",
				"luacheck", -- Lua linting

				-- Additional useful tools
				-- "delve",      -- Go debugger
				-- "shfmt",      -- Shell formatter
				-- "shellcheck", -- Shell linter

				-- Optional but useful additions
				-- "markdownlint", -- Markdown linting
				-- "yamllint",     -- YAML linting
				-- "jsonlint",     -- JSON linting
			},
		},
	},
}
