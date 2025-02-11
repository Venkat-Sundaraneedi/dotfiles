return {
	-- conform.nvim
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "beautysh" },
				python = { "autoflake" },
				solidity = { "forge_fmt" },
				javascript = { "biome" },
				json = { "biome" },
				typescript = { "biome" },
				markdown = { "cbfmt" },
			},

			formatters = {
				stylua = {},
				cbfmt = {},
				beautysh = {},
				autoflake = {},
				biome = {},
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
