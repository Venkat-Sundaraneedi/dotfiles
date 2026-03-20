-- Credits to original https://github.com/sainnhe/gruvbox-material
-- Ported from Helix theme by @satoqz
-- Dark Medium variant
local M = {}

-- Palette (1:1 from Helix theme)
-- fg0    = #d4be98   fg1    = #ddc7a1
-- bg0    = #282828   bg1    = #32302f   bg2    = #45403d
-- bg3    = #5a524c   bg4    = #504945
-- grey0  = #7c6f64   grey1  = #928374   grey2  = #a89984
-- aqua   = #89b482   blue   = #7daea3   green  = #a9b665
-- orange = #e78a4e   purple = #d3869b   red    = #ea6962
-- yellow = #d8a657

M.base_30 = {
  white = "#d4be98", -- fg0
  darker_black = "#1b1b1b", -- below bg0 (bg_dim from material palette)
  black = "#282828", -- bg0  <- nvim bg
  black2 = "#2e2c2b", -- between bg0 and bg1
  one_bg = "#32302f", -- bg1
  one_bg2 = "#3a3735", -- between bg1 and bg2
  one_bg3 = "#45403d", -- bg2
  grey = "#504945", -- bg4
  grey_fg = "#5a524c", -- bg3
  grey_fg2 = "#665c54", -- slightly above bg3
  light_grey = "#7c6f64", -- grey0
  red = "#ea6962", -- red
  baby_pink = "#e78a4e", -- orange (warm accent)
  pink = "#d3869b", -- purple
  line = "#3a3735", -- vertsplit -- between bg1/bg2
  green = "#a9b665", -- green
  vibrant_green = "#a9b665", -- green (same, no harsh neon here)
  nord_blue = "#7daea3", -- blue
  blue = "#7daea3", -- blue
  yellow = "#d8a657", -- yellow
  sun = "#d8a657", -- yellow
  purple = "#d3869b", -- purple
  dark_purple = "#d3869b", -- purple
  teal = "#89b482", -- aqua
  orange = "#e78a4e", -- orange
  cyan = "#89b482", -- aqua
  statusline_bg = "#32302f", -- bg1
  lightbg = "#45403d", -- bg2
  pmenu_bg = "#7daea3", -- blue
  folder_bg = "#89b482", -- aqua
}

M.base_16 = {
  base00 = "#282828", -- bg0   -- background
  base01 = "#32302f", -- bg1   -- lighter background (status bars)
  base02 = "#45403d", -- bg2   -- selection background
  base03 = "#928374", -- grey1 -- comments
  base04 = "#7c6f64", -- grey0 -- dark foreground (status bars)
  base05 = "#d4be98", -- fg0   -- default foreground
  base06 = "#ddc7a1", -- fg1   -- light foreground
  base07 = "#d4be98", -- fg0   -- lightest foreground
  base08 = "#ea6962", -- red   -- variables, xml tags, markup link text
  base09 = "#e78a4e", -- orange -- integers, booleans, constants
  base0A = "#d8a657", -- yellow -- classes, search text background
  base0B = "#a9b665", -- green  -- strings, inherited class, markup code
  base0C = "#89b482", -- aqua   -- support, regex, escape chars
  base0D = "#7daea3", -- blue   -- functions, methods, attribute IDs
  base0E = "#d3869b", -- purple -- keywords, storage, selector
  base0F = "#e78a4e", -- orange -- deprecated, opening/closing embed tags
}

M.type = "dark"
M = require("base46").override_theme(M, "gruvbox_material_dark_medium")

M.polish_hl = {
  syntax = {
    Operator = { fg = M.base_30.orange },
    Keyword = { fg = M.base_30.red },
    Type = { fg = M.base_30.yellow },
    String = { fg = M.base_30.teal },
    Number = { fg = M.base_30.purple },
    Constant = { fg = M.base_30.purple },
    Function = { fg = M.base_30.green },
    Comment = { fg = M.base_30.light_grey, italic = true },
    Namespace = { fg = M.base_30.yellow },
    Label = { fg = M.base_30.red },
    Tag = { fg = M.base_30.orange },
    Special = { fg = M.base_30.green },
  },
  treesitter = {
    ["@operator"] = { fg = M.base_30.orange },
    ["@keyword"] = { fg = M.base_30.red },
    ["@keyword.operator"] = { fg = M.base_30.orange },
    ["@keyword.directive"] = { fg = M.base_30.purple },
    ["@type"] = { fg = M.base_30.yellow },
    ["@type.builtin"] = { fg = M.base_30.yellow },
    ["@string"] = { fg = M.base_30.teal },
    ["@string.regex"] = { fg = M.base_30.green },
    ["@string.escape"] = { fg = M.base_30.green },
    ["@number"] = { fg = M.base_30.purple },
    ["@constant"] = { fg = M.base_30.white },
    ["@constant.builtin"] = { fg = M.base_30.purple },
    ["@function"] = { fg = M.base_30.green },
    ["@function.builtin"] = { fg = M.base_30.green },
    ["@constructor"] = { fg = M.base_30.green },
    ["@variable"] = { fg = M.base_30.white },
    ["@variable.builtin"] = { fg = M.base_30.purple },
    ["@variable.parameter"] = { fg = M.base_30.white },
    ["@field"] = { fg = M.base_30.blue },
    ["@property"] = { fg = M.base_30.blue },
    ["@namespace"] = { fg = M.base_30.yellow },
    ["@label"] = { fg = M.base_30.red },
    ["@tag"] = { fg = M.base_30.orange },
    ["@tag.attribute"] = { fg = M.base_30.green },
    ["@punctuation.bracket"] = { fg = M.base_30.white },
    ["@punctuation.delimiter"] = { fg = M.base_30.light_grey },
    ["@punctuation.special"] = { fg = M.base_30.blue },
    ["@comment"] = { fg = M.base_30.light_grey, italic = true },
    ["@attribute"] = { fg = M.base_30.green },
    ["@special"] = { fg = M.base_30.green },
  },
}

return M
