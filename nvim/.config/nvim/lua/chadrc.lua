-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",
  hl_override = {
    ["@comment"] = { italic = true },
  },
}
M.ui = {
  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_coloreda
    format_colors = {
      tailwind = false,
      icon = "󱓻",
    },
  },

  telescope = { style = "bordered" }, -- borderless / bordered

  statusline = {
    enabled = true,
    theme = "default", -- default,vscode,vscode_colored,minimal
    separator_style = "block", -- default,round,block,arrow
    order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
    modules = {
      f = "%F",
    },
  },
  -- lazyload it When There are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = {}, --nil
  },
}

M.nvdash = {
  load_on_startup = false,
}

M.lsp = { signature = false }

return M
