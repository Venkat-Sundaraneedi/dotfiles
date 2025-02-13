return {
	-- nvim treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = {

			--WARN: THIS IS FOR WINDOWS ONLY
			-- prefer_git = false,
			-- compilers ={"gcc"},

			ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "solidity", "rust", "kdl", "bash" },

			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = { enable = true },
		},
		config = function(_, opts)
			pcall(function()
				dofile(vim.g.base46_cache .. "syntax")
				dofile(vim.g.base46_cache .. "treesitter")
			end)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
