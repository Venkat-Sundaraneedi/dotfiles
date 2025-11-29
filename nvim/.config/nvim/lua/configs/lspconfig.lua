require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("nil_ls", {
  formatting = {
    command = { "nixfmt" },
  },
})

local servers = { "rust_analyzer", "nil_ls" }
vim.lsp.enable(servers)
