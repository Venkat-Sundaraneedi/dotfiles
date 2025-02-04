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
				python = { "black" },
				solidity = { "forge_fmt" },
				javascript = { "biome" },
				json = { "biome" },
				typescript = { "biome" },
				markdown = { "cbfmt" },
				-- solidity = { "prettierd" },
				-- kotlin = { "ktfmt" },
				-- java = { "clang_format" },
				-- html = { "prettierd" },
				-- c = { "ast_grep" },
				-- cpp = { "ast_grep" },
				-- css = { "prettier" },
				-- html = { "prettier" },
			},

			formatters = {
				stylua = {},
				cbfmt = {},
				beautysh = {},
				clang_format = {},
				black = {},
				biome = {},
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
