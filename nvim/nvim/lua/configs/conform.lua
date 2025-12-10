local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome" },
    json = { "biome" },
    typescript = { "biome" },
    -- move = { "movefmt" },
  },

  formatters = {
    movefmt = {
      command = "movefmt",
      -- args = function(self, ctx)
      args = function()
        return {
          "--stdin",
          "--quiet",
          "--config-path",
          vim.fn.getcwd(), -- or ctx.dirname for file's directory
        }
      end,
    },
  },
}

return options
