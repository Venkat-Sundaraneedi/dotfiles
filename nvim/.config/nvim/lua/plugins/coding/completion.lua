return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdLineEnter" },

		dependencies = {

			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
			},
		},

		opts = function()
			dofile(vim.g.base46_cache .. "blink")

			return {
				cmdline = {
					enabled = true,
				},
				appearance = { nerd_font_variant = "normal" },
				fuzzy = {
					implementation = "prefer_rust_with_warning",

					sorts = {
						"exact",
						"score",
						"sort_text",
					},
				},

				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
				accept = { auto_brackets = { enabled = true } },
				signature = { enabled = true, window = { border = "single", show_documentation = false } },
				sources = { default = { "lsp", "buffer", "path" } },

				keymap = {
					preset = "default",
					["<CR>"] = { "accept", "fallback" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-space>"] = { "hide", "show" },
				},

				completion = {
					ghost_text = { enabled = false },
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 200,
						window = { border = "single" },
					},

					menu = require("nvchad.blink").menu,
				},
			}
		end,
	},

	{
		-- snippet plugin
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		opts = function()
			return {
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			}
		end,
		config = function(_, opts)
			require("luasnip").config.set_config(opts)

			local ls = require("luasnip")
			local map = vim.keymap.set

			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

			map({ "i", "s" }, "<tab>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			map({ "i", "s" }, "<s-tab>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			map({ "i", "s" }, "<A-c>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
