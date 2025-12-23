require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("taplo", {})
vim.lsp.config("zls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("aptos_language_server", {
  cmd = { "aptos-language-server", "lsp-server" },
  filetypes = { "move" },
  root_markers = { "Move.toml", "Cargo.toml", ".git" },
  on_init = function(client, initialize_result)
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = initialize_result.capabilities.semanticTokensProvider
    end
  end,
})

local servers = { "rust_analyzer", "taplo", "zls", "ts_ls", "aptos-language-server" }
vim.lsp.enable(servers)
