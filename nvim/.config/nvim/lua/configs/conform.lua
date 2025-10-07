local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome" },
    json = { "biome" },
    typescript = { "biome" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  lsp_format = {
    async = true,
    timeout_ms = 1000,
  },
}

return options
