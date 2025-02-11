---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "yoru",
	hl_add = {},
	hl_override = {},
	integrations = {},
	changed_themes = {},
	transparency = false,
	theme_toggle = { "onedark", "one_light" },
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
		enabled = false,
	},

	-- lazyload it When There are 1+ buffers
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "buffers", "tabs", "btns", "treeOffset" },
		modules = {}, --nil
	},
}

M.nvdash = {
	load_on_startup = true,

	header = {
		"                            ",
		"     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
		"   ▄▀███▄     ▄██ █████▀    ",
		"   ██▄▀███▄   ███           ",
		"   ███  ▀███▄ ███           ",
		"   ███    ▀██ ███           ",
		"   ███      ▀ ███           ",
		"   ▀██ █████▄▀█▀▄██████▄    ",
		"     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
		"                            ",
		"     Powered By  eovim    ",
		"                            ",
	},

	buttons = {
		{ txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
		{ txt = "🧾 Recent Files", keys = "o", cmd = "Telescope oldfiles" },
		{ txt = "  Session", keys = "s", cmd = "lua require('persistence').load({ last = true })" },
		{ txt = "󰩈 Quit", keys = "q", cmd = ":qa" },

		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " ms"
				return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
		},

		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	},
}

M.term = {
	winopts = { number = false },
	sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
	float = {
		relative = "editor",
		row = 0.3,
		col = 0.25,
		width = 0.5,
		height = 0.4,
		border = "single",
	},
}

M.lsp = { signature = false }

M.cheatsheet = {
	theme = "grid", -- simple/grid
	excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
}

M.mason = { pkgs = {} }

M.colorify = {
	enabled = true,
	mode = "virtual", -- fg, bg, virtual
	virt_text = "󱓻 ",
	highlight = { hex = true, lspvars = true },
}

return M
