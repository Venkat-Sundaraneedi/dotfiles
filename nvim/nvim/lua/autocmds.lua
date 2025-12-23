-- //========== autocmds ==========//

require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").move_on_aptos = {
      install_info = {
        path = "/home/greed/projects/git/tree-sitter-move-on-aptos/",
        queries = "queries",
      },
    }
  end,
})

-- Register the parser name with the filetype 'move'
vim.treesitter.language.register("move_on_aptos", { "move" })

autocmd("FileType", {
  pattern = { "move", "noir" },
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
