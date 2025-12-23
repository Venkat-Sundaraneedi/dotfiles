local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    move = { "movefmt" },
  },

  formatters = {
    movefmt = {
      command = "movefmt",
      args = function()
        return {
          "--stdin",
          "--quiet",
          "--config-path",
          vim.fn.getcwd(),
        }
      end,
    },
  },
}

return options
