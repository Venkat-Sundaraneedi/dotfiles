return {
	"mfussenegger/nvim-lint",
	lazy = true,
	config = function()
		require("lint").linters_by_ft = {
			markdown = { "vale" },
			bash = { "shellcheck" },
			json = { "deno_lint" },
			javascript = { "deno_lint" },
			typescript = { "deno_lint" },
		}
		require("lint").linters = {
			vale = {},
			deno_lint = {
				cmd = "deno",
				args = { "lint" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
			},
			shellcheck = {
				cmd = "/home/greed/.local/share/nvim/mason/packages/shellcheck/shellcheck",
			},
			biome = {},
			-- your_linter_name = {
			-- 	cmd = "linter_cmd",
			-- 	stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
			-- 	append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
			-- 	args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
			-- 	stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
			-- 	ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
			-- 	env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
			-- 	parser = your_parse_function,
			-- },
		}
	end,
}
