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
				left = "<M-h>",
				right = "<M-l>",
				down = "<M-j>",
				up = "<M-k>",

				-- Move current line in Normal mode
				line_left = "<C-h>",
				line_right = "<C-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},

			-- Options which control moving behavior
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		},
	},
}
