local function custom_indent_textobject()
	return {
		a = function()
			local start_line = vim.fn.search("\\v^\\s*$", "bW") -- Search for empty line before indented block
			local end_line = vim.fn.search("\\v^\\s*$", "W") -- Search for empty line after indented block
			return start_line .. "," .. end_line
		end,
		i = function()
			local start_line = vim.fn.search("\\v^\\s*\\S", "bW") -- Start of indented block
			local end_line = vim.fn.search("\\v^\\s*$", "W") -- End of indented block
			return start_line .. "," .. end_line
		end,
	}
end

local function custom_buffer_textobject()
	return {
		a = function()
			return "1,$" -- Entire buffer
		end,
		i = function()
			local start_line = vim.fn.search("\\v\\S", "W") -- First non-empty line
			local end_line = vim.fn.search("\\v\\S", "bW") -- Last non-empty line
			return start_line .. "," .. end_line
		end,
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
return {
	-- mini.ai
	{
		"echasnovski/mini.ai",
		lazy = true,
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					d = { "%f[%d]%d+" },
					e = {
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					i = custom_indent_textobject(),
					g = custom_buffer_textobject(),
					u = ai.gen_spec.function_call(),
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
				},
			}
		end,
	},

	-- mini move
	{
		"echasnovski/mini.move",
		event = "VeryLazy",
		opts = {
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<A-h>",
				right = "<A-l>",
				down = "<A-j>",
				up = "<A-k>",

				-- Move current line in Normal mode
				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			},

			-- Options which control moving behavior
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		},
	},

	-- mini indentscope
	{
		"echasnovski/mini.indentscope",
		enabled = true,
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufRead", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			mappings = {
				object_scope = "ii",
				object_scope_with_border = "ai",
				goto_top = "gpi",
				goto_bottom = "gni",
			},
			options = {
				-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
				border = "both",

				indent_at_cursor = true,

				-- Whether to first check input line to be a border of adjacent scope.
				-- Use it if you want to place cursor on function header to get scope of
				-- its body.
				try_as_border = false,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"alpha",
					"dashboard",
					"fzf",
					"help",
					"lazy",
					"lazyterm",
					"mason",
					"neo-tree",
					"notify",
					"toggleterm",
					"Trouble",
					"trouble",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		enabled = true,
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},
}
