if lazyvim does not install automatically then you have to install lazyvim plugin manager with this

  Remove-Item -Path "$env:LOCALAPPDATA\nvim\data\lazy" -Recurse -Force
  git clone https://github.com/folke/lazy.nvim.git "$env:LOCALAPPDATA\nvim\data\lazy\lazy.nvim"
  nvim -c "lua require('lazy').sync()"

as for telescope comment out
  local actions = require("telescope.actions")

if you are using windows then install gcc and g++ first for treesitter see the config of treesitter you have to change 2 options

