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
				beautysh = {
					{
						cmd = "/home/greed/.asdf/shims/beautysh",
						-- args = { "fmt" },
						-- stdin = false,
					},
				},
				autoflake = {},
				biome = {},
				forge_fmt = {
					{
						cmd = "/home/greed/.config/.cargo/bin/forge",
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
