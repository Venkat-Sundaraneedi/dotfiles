require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("lua_ls", {})
vim.lsp.config("taplo", {})
vim.lsp.config("yamlls", {})
vim.lsp.config("solidity_ls_nomicfoundation", {})

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

local servers = { "rust_analyzer", "ts_ls", "aptos_language_server", "solidity_ls_nomicfoundation", "taplo", "yamlls" }
vim.lsp.enable(servers)
