return {
	-- mason
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			return require("nvchad.configs.mason")
		end,
	},
	-- mason-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
					"biome",
					"pyright",
					"marksman",
					"bashls",
					"solidity_ls_nomicfoundation",
					"rust_analyzer",
					"autoflake",
					"beautysh",
					"cbfmt",
					"stylua",
					"vale",
				},
			})
		end,
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "User FilePost",

		config = function()
			local map = vim.keymap.set

			--  on_attach
			local on_attach = function(_, bufnr)
				local function opts(desc)
					return { buffer = bufnr, desc = "LSP " .. desc }
				end

				map("n", "<leader>gk", vim.lsp.buf.hover, opts("Go to declaration"))
				map("n", "<leader>gD", vim.lsp.buf.declaration, opts("Go to declaration"))
				map("n", "<leader>gd", vim.lsp.buf.definition, opts("Go to definition"))
				map("n", "<leader>gi", vim.lsp.buf.implementation, opts("Go to implementation"))
				-- map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
				-- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
				-- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

				-- inc-rename
				map("n", "<leader>cr", function()
					local inc_rename = require("inc_rename")
					return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
				end, { expr = true, desc = "Rename with inc_rename", silent = true })

				-- map("n", "<leader>wl", function()
				-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts("List workspace folders"))

				-- map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
				-- map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))

				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
				map("n", "<leader>gr", vim.lsp.buf.references, opts("Show references"))
			end

			-- on_init
			local on_init = function(client, _)
				if client.supports_method("textDocument/semanticTokens") then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			local util = require("lspconfig.util")
			local servers = {
				denols = {
					cmd = { "deno", "lsp" },
					cmd_env = { NO_COLOR = true },
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					root_dir = util.root_pattern("deno.json", "deno.jsonc", ".git"),
					settings = {
						deno = {
							enable = true,
							suggest = {
								imports = {
									hosts = {
										["https://deno.land"] = true,
									},
								},
							},
						},
					},
					handlers = {
						["textDocument/definition"] = denols_handler,
						["textDocument/typeDefinition"] = denols_handler,
						["textDocument/references"] = denols_handler,
					},
				},
				lua_ls = {},
				jdtls = {},
				cairo_ls = {
					init_options = { hostInfo = "neovim" },
					cmd = { "scarb-cairo-language-server", "/C", "--node-ipc" },
					filetypes = { "cairo" },
					root_dir = util.root_pattern("Scarb.toml", "cairo_project.toml", ".git"),
				},
				biome = {},
				pyright = {},
				harper_ls = {
					filetypes = { "markdown" },
				},
				bashls = {
					cmd = { "bash-language-server", "start" },
					settings = {
						bashIde = {
							globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
						},
					},
					filetypes = { "bash", "sh" },
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
					end,
					single_file_support = true,
				},

				solidity_ls_nomicfoundation = {},
				rust_analyzer = {
					cmd = {
						"/home/greed/.asdf/installs/rust/1.85.0/bin/rust-analyzer",
					},
				},
			}

			-- Install Sway LSP as a custom	server
			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")

			-- Check if the config is already defined (useful when reloading this file)
			if not configs.sway_lsp then
				configs.sway_lsp = {
					default_config = {
						cmd = { "forc-lsp" },
						filetypes = { "sway" },
						on_attach = on_attach,
						init_options = {
							-- Any initialization options
							logging = { level = "trace" },
						},
						root_dir = function(fname)
							return lspconfig.util.find_git_ancestor(fname)
						end,
						settings = {},
					},
				}
			end

			lspconfig.sway_lsp.setup({})

			for name, opts in pairs(servers) do
				opts.on_attach = on_attach
				opts.on_init = on_init
				opts.capabilities = capabilities

				require("lspconfig")[name].setup(opts)
			end
		end,
	},
}
