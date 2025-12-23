-- //========== autocmds ==========//

require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "cairo", "noir" },
  callback = function()
    vim.bo.commentstring = "// %s"
    vim.treesitter.start()
  end,
})

vim.treesitter.language.register("rust", "noir")

vim.filetype.add {
  extension = {
    sw = "sway",
    move = "move",
    nr = "noir",
  },
  filename = {
    ["Forc.toml"] = "toml", -- For Fuel project config files
  },
}
