require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.keymap.set({ "n", "x", "o" }, "f", function()
      require("flash").jump()
    end, { desc = "Flash Jump" })
  end,
})
