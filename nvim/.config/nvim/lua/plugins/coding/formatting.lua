return {
	-- conform.nvim
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				toml = { "taplo" },
				solidity = { "forge_fmt" },
				javascript = { "deno_fmt" },
				json = { "deno_fmt" },
				typescript = { "deno_fmt" },
				-- markdown = { "cbfmt" },
			},

			formatters = {
				deno_fmt = {
					{
						cmd = "deno",
						args = { "fmt" },
						stdin = false,
					},
				},
				stylua = {},
				forge_fmt = {
					{
						cmd = "/home/codezeros/.foundry/bin/forge",
						args = { "fmt" },
						stdin = false,
					},
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			lsp_format = {
				async = true,
				timeout_ms = 1000,
			},
		},
	},
}
