local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- nix = { "nixfmt" },
    nix = { "alejandra" },
  },
}

return options
