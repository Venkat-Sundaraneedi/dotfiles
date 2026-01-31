-- //========== autocmds ==========//

require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "ron" },
  callback = function()
    vim.bo.commentstring = "// %s"
    vim.treesitter.start()
  end,
})

vim.filetype.add {
  extension = {
    -- sw = "sway",
  },
  filename = {
    -- ["Forc.toml"] = "toml",
  },
}
