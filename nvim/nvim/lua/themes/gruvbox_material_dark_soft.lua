-- Credits to original https://github.com/sainnhe/gruvbox-material
-- Dark Soft variant — lightest background, softest contrast
local M = {}

M.base_30 = {
  white = "#d4be98", -- fg0 (material palette)
  darker_black = "#252423", -- bg_dim
  black = "#32302f", -- bg0 (nvim bg)
  black2 = "#383431", -- between bg0 and bg1
  one_bg = "#3c3836", -- bg1
  one_bg2 = "#46413e", -- bg_statusline2
  one_bg3 = "#504945", -- bg3
  grey = "#665c54", -- bg5
  grey_fg = "#6e6259", -- slightly lighter
  grey_fg2 = "#7c6f64", -- grey0
  light_grey = "#928374", -- grey1
  red = "#ea6962", -- red
  baby_pink = "#f28534", -- orange-ish
  pink = "#d3869b", -- purple
  line = "#46413e", -- for lines like vertsplit (bg_statusline2)
  green = "#a9b665", -- green
  vibrant_green = "#b8bb26", -- original green
  nord_blue = "#7daea3", -- blue
  blue = "#7daea3", -- blue
  yellow = "#d8a657", -- yellow
  sun = "#e9b143", -- brighter yellow
  purple = "#d3869b", -- purple
  dark_purple = "#945e80", -- darker purple
  teal = "#89b482", -- aqua
  orange = "#e78a4e", -- orange
  cyan = "#89b482", -- aqua
  statusline_bg = "#3c3836", -- bg1
  lightbg = "#504945", -- bg3
  pmenu_bg = "#7daea3", -- blue
  folder_bg = "#89b482", -- aqua
}

M.base_16 = {
  base00 = "#32302f", -- bg0 (background)
  base01 = "#3c3836", -- bg1
  base02 = "#46413e", -- bg_statusline2
  base03 = "#504945", -- bg3
  base04 = "#7c6f64", -- grey0
  base05 = "#d4be98", -- fg0
  base06 = "#ddc7a1", -- fg1
  base07 = "#ebdbb2", -- brighter fg
  base08 = "#ea6962", -- red
  base09 = "#e78a4e", -- orange
  base0A = "#d8a657", -- yellow
  base0B = "#a9b665", -- green
  base0C = "#89b482", -- aqua
  base0D = "#7daea3", -- blue
  base0E = "#d3869b", -- purple
  base0F = "#ea6962", -- red (alt)
}

M.type = "dark"
M = require("base46").override_theme(M, "gruvbox_material_dark_soft")

M.polish_hl = {
  syntax = {
    Operator = { fg = M.base_30.nord_blue },
  },
  treesitter = {
    ["@operator"] = { fg = M.base_30.nord_blue },
  },
}

return M
