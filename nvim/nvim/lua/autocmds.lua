require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "ron", "nu" },
  callback = function()
    -- vim.bo.commentstring = "// %s"
    vim.treesitter.start()
  end,
})
