return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "main",
		opts = function()
			return {
				require("nvchad.configs.treesitter"),
				ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "rust", "solidity" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

						keymaps = {
							-- Replicating mini.ai's 'o', 'f', 'c' (Tree-sitter based)
							["ao"] = "@block.outer", -- 'a'round 'o'bject (general block/statement)
							["io"] = "@block.inner", -- 'i'nner 'o'bject (general block/statement)
							["af"] = "@function.outer", -- 'a'round 'f'unction
							["if"] = "@function.inner", -- 'i'nner 'f'unction
							["ac"] = "@class.outer", -- 'a'round 'c'lass
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" }, -- 'i'nner 'c'lass

							["at"] = "@tag.outer", -- 'a'round 't'ag (for HTML, XML, JSX, TSX)
							["it"] = "@tag.inner", -- 'i'nner 't'ag

							["ad"] = "@number.outer", -- 'a'round 'd'igit/number
							["id"] = "@number.inner", -- 'i'nner 'd'igit/number

							["ae"] = "@identifier.outer", -- 'a'round 'e'lement (identifier/variable)
							["ie"] = "@identifier.inner", -- 'i'nner 'e'lement

							["ai"] = "@block.outer", -- 'a'round 'i'ndented block (syntax block)
							["ii"] = "@block.inner", -- 'i'nner 'i'ndented block (syntax block)

							["aC"] = "@conditional.outer", -- 'a'round 'C'onditional (using Cap C to avoid conflict)
							["iC"] = "@conditional.inner", -- 'i'nner 'C'onditional
							["aL"] = "@loop.outer", -- 'a'round 'L'oop (using Cap L)
							["iL"] = "@loop.inner", -- 'i'nner 'L'oop
							["aB"] = "@block.outer", -- 'a'round 'B'lock (using Cap B)
							["iB"] = "@block.inner", -- 'i'nner 'B'lock

							-- Replicating mini.ai's 'u', 'U' (function call)
							["au"] = "@call.outer", -- 'a'round 'u'se (function call)
							["iu"] = "@call.inner", -- 'i'nner 'u'se

							-- Standard helpful text objects (parameters, assignments, statements)
							["ap"] = "@parameter.outer", -- 'a'round 'p'arameter
							["ip"] = "@parameter.inner", -- 'i'nner 'p'arameter
							["a="] = "@assignment.outer", -- 'a'round 'assignment'
							["i="] = "@assignment.inner", -- 'i'nner 'assignment'
							["aS"] = "@statement.outer", -- 'a'round 'S'tatement
							["iS"] = "@statement.inner", -- 'i'nner 'S'tatement (if available for language)
						},

						-- You can choose the select mode (default is charwise 'v')
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
							["@block.outer"] = "V", -- linewise selection for blocks
							["@loop.outer"] = "V",
							["@conditional.outer"] = "V",
							["@identifier.outer"] = "v", -- identifiers usually charwise
						},
						include_surrounding_whitespace = true,
					},

					-- swap = {
					-- 	enable = true,
					-- 	swap_next = {
					-- 		["<leader>sp"] = "@parameter.inner", -- 's'wap 'p'arameter next
					-- 		["<leader>sf"] = "@function.outer", -- swap with next function (if applicable)
					-- 		["<leader>ss"] = "@statement.outer", -- swap with next statement (if applicable)
					-- 	},
					-- 	swap_previous = {
					-- 		["<leader>Sp"] = "@parameter.inner", -- 'S'wap 'p'arameter previous
					-- 		["<leader>Sf"] = "@function.outer", -- swap with previous function
					-- 		["<leader>Ss"] = "@statement.outer", -- swap with previous statement
					-- 	},
					-- },

					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = { query = "@class.outer", desc = "Next class start" },
							["]l"] = "@loop.outer",
							["]i"] = "@conditional.outer",
							["]b"] = "@block.outer",
							["]s"] = { query = "@statement.outer", desc = "Next statement start" },
							["]a"] = "@assignment.outer",
							["]p"] = "@parameter.outer",
						},
						goto_next_end = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[l"] = "@loop.outer",
							["[i"] = "@conditional.outer",
							["[b"] = "@block.outer",
							["[s"] = "@statement.outer",
							["[a"] = "@assignment.outer",
							["[p"] = "@parameter.outer",
							["[t"] = "@tag.outer",
						},
						goto_previous_start = {
							["[[f"] = "@function.outer",
							["[[c"] = "@class.outer",
							["[[l"] = "@loop.outer",
							["[[i"] = "@conditional.outer",
							["[[b"] = "@block.outer",
							["[[s"] = "@statement.outer",
							["[[a"] = "@assignment.outer",
							["[[p"] = "@parameter.outer",
							["[[t"] = "@tag.outer",
						},
						goto_previous_end = {
							["[]f"] = "@function.outer",
							["[]c"] = "@class.outer",
							["[]l"] = "@loop.outer",
							["[]i"] = "@conditional.outer",
							["[]b"] = "@block.outer",
							["[]s"] = "@statement.outer",
							["[]a"] = "@assignment.outer",
							["[]p"] = "@parameter.outer",
							["[]t"] = "@tag.outer",
						},
					},
				},
			})
		end,
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	lazy = false, -- It should always be active to provide context
	-- 	config = function()
	-- 		require("treesitter-context").setup({
	-- 			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	-- 			multiwindow = false, -- Enable multiwindow support.
	-- 			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	-- 			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	-- 			line_numbers = true,
	-- 			multiline_threshold = 20, -- Maximum number of lines to show for a single context
	-- 			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	-- 			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- 			-- Separator between context and content. Should be a single character string, like '-'.
	-- 			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	-- 			separator = nil,
	-- 			zindex = 20, -- The Z-index of the context window
	-- 			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	-- 		})
	-- 	end,
	-- },
}
