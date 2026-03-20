require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    map({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end, { desc = "Flash Jump" })
    map("v", "f", "<cmd>noh<CR><ESC>")
    vim.keymap.del("n", "f")
  end,
})
