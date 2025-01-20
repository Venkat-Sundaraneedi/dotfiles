return {
	-- conform.nvim
	{
		"stevearc/conform.nvim",
		lazy = false,
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "beautysh" },
				markdown = { "mdformat" },
				kotlin = { "ktfmt" },
				java = { "clang_format" },
				-- rust = { "ast_grep" },
				-- ["_"] = { "ast_grep" },
				python = { "black" },
				solidity = { "forge_fmt" },
				-- solidity = { "prettierd" },
				javascript = { "prettierd", "prettier" },
				-- json = { "prettierd", "biome" },
				typescript = { "prettierd", "prettier" },
				-- html = { "prettierd" },
				-- c = { "ast_grep" },
				-- cpp = { "ast_grep" },
				-- css = { "prettier" },
				-- html = { "prettier" },
			},

			formatters = {
				stylua = {},
				ktfmt = {},
				mdformat = {},
				nixpkgs_fmt = {},
				beautysh = {},
				clang_format = {},
				black = {},
				prettier = {},
				prettierd = {},
				forge_fmt = {
					{
						cmd = "/home/greed/.foundry/bin/forge",
						args = { "fmt" },
						stdin = false,
					},
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
