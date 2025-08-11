return {
	-- persist session
	{
		"folke/persistence.nvim",
		lazy = true,
		event = "BufReadPre",
		opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>q", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    },
	},
	-- plenary
	{ "nvim-lua/plenary.nvim", lazy = true },
}
