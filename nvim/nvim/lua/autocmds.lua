-- //========== autocmds ==========//

require "nvchad.autocmds"

local vim = vim
local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").move_on_aptos = {
      install_info = {
        path = "/home/codezeros/project/git/tree-sitter-move-on-aptos",
        queries = "queries",
      },
    }
  end,
})

-- Register the parser name with the filetype 'move'
vim.treesitter.language.register("move_on_aptos", { "move" })

autocmd("FileType", {
  pattern = { "move", "ron" },
  callback = function()
    vim.bo.commentstring = "// %s"
    vim.treesitter.start()
  end,
})

vim.filetype.add {
  extension = {
    sw = "sway",
    move = "move",
    log = "log",
  },
  filename = {
    ["Forc.toml"] = "toml", -- For Fuel project config files
  },
}
