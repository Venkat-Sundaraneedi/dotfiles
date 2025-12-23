require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("taplo", {})
vim.lsp.config("zls", {})
vim.lsp.config("ts_ls", {})

local servers = { "rust_analyzer", "taplo", "zls", "ts_ls" }
vim.lsp.enable(servers)
