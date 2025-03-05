return {
	-- persist session
	{
		"folke/persistence.nvim",
		lazy = true,
		event = "BufReadPre",
		opts = {},
    -- stylua: ignore
    keys = {
      -- { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      -- { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>q", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      -- { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},

	-- plenary
	{ "nvim-lua/plenary.nvim", lazy = true },
}
