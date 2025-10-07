require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("denols", {})
vim.lsp.config("copilot", {})

local servers = { "rust_analyzer", "denols", "copilot" }
vim.lsp.enable(servers)
