# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_nargo_global_optspecs
	string join \n program-dir= target-dir= h/help V/version
end

function __fish_nargo_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_nargo_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_nargo_using_subcommand
	set -l cmd (__fish_nargo_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c nargo -n "__fish_nargo_needs_command" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_needs_command" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_needs_command" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_needs_command" -s V -l version -d 'Print version'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "check" -d 'Check a local package and all of its dependencies for errors'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "c" -d 'Check a local package and all of its dependencies for errors'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "fmt" -d 'Format the Noir files in a workspace'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "compile" -d 'Compile the program and its secret execution trace into ACIR format'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "interpret" -d 'Compile the program and interpret the SSA after each pass, printing the results to the console'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "new" -d 'Create a Noir project in a new directory'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "init" -d 'Create a Noir project in the current directory'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "execute" -d 'Executes a circuit to calculate its return value'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "e" -d 'Executes a circuit to calculate its return value'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "export" -d 'Exports functions marked with #[export] attribute'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "debug" -d 'Executes a circuit in debug mode'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "test" -d 'Run the tests for this program'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "t" -d 'Run the tests for this program'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "fuzz" -d 'Run the fuzzing harnesses for this program'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "f" -d 'Run the fuzzing harnesses for this program'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "info" -d 'Provides detailed information on each of a program\'s function (represented by a single circuit)'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "i" -d 'Provides detailed information on each of a program\'s function (represented by a single circuit)'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "lsp" -d 'Starts the Noir LSP server'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "dap"
complete -c nargo -n "__fish_nargo_needs_command" -f -a "expand" -d 'Show the result of macro expansion'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "generate-completion-script" -d 'Generates a shell completion script for your favorite shell'
complete -c nargo -n "__fish_nargo_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand check" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand check" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand check" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l overwrite -d 'Force overwrite of existing files'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand check" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand check" -l show-program-hash -d 'Just show the hash of each packages, without actually performing the check'
complete -c nargo -n "__fish_nargo_using_subcommand check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand c" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand c" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand c" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l overwrite -d 'Force overwrite of existing files'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand c" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand c" -l show-program-hash -d 'Just show the hash of each packages, without actually performing the check'
complete -c nargo -n "__fish_nargo_using_subcommand c" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -l check -d 'Run noirfmt in check mode'
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand fmt" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -l watch -d 'Watch workspace and recompile on changes'
complete -c nargo -n "__fish_nargo_using_subcommand compile" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -s p -l prover-name -d 'The name of the TOML file which contains the ABI encoded inputs' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l ssa-pass -d 'The name of the SSA passes we want to interpret the results at' -r
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -l trace -d 'If true, the interpreter will trace its execution'
complete -c nargo -n "__fish_nargo_using_subcommand interpret" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand new" -l name -d 'Name of the package [default: package directory name]' -r
complete -c nargo -n "__fish_nargo_using_subcommand new" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand new" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand new" -l lib -d 'Use a library template'
complete -c nargo -n "__fish_nargo_using_subcommand new" -l bin -d 'Use a binary template [default]'
complete -c nargo -n "__fish_nargo_using_subcommand new" -l contract -d 'Use a contract template'
complete -c nargo -n "__fish_nargo_using_subcommand new" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_using_subcommand init" -l name -d 'Name of the package [default: current directory name]' -r
complete -c nargo -n "__fish_nargo_using_subcommand init" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand init" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand init" -l lib -d 'Use a library template'
complete -c nargo -n "__fish_nargo_using_subcommand init" -l bin -d 'Use a binary template [default]'
complete -c nargo -n "__fish_nargo_using_subcommand init" -l contract -d 'Use a contract template'
complete -c nargo -n "__fish_nargo_using_subcommand init" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -s p -l prover-name -d 'The name of the toml file which contains the inputs for the prover' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l oracle-file -d 'Path to the oracle transcript' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand execute" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand e" -s p -l prover-name -d 'The name of the toml file which contains the inputs for the prover' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand e" -l oracle-file -d 'Path to the oracle transcript' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand e" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand e" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand e" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand e" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand e" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand e" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand export" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand export" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand export" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand export" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand export" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand export" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -s p -l prover-name -d 'The name of the toml file which contains the inputs for the prover' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l package -d 'The name of the package to execute' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l skip-instrumentation -d 'Disable vars debug instrumentation (enabled by default)' -r -f -a "true\t''
false\t''"
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l raw-source-printing -d 'Raw string printing of source for testing' -r -f -a "true\t''
false\t''"
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l test-name -d 'Name (or substring) of the test function to debug' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -l acir-mode -d 'Force ACIR output (disabling instrumentation)'
complete -c nargo -n "__fish_nargo_using_subcommand debug" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l test-threads -d 'Number of threads used for running tests in parallel' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l format -d 'Configure formatting of output' -r -f -a "pretty\t'Print verbose output'
terse\t'Display one character per test'
json\t'Output a JSON Lines document'"
complete -c nargo -n "__fish_nargo_using_subcommand test" -l corpus-dir -d 'If given, load/store fuzzer corpus from this folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l minimized-corpus-dir -d 'If given, perform corpus minimization instead of fuzzing and store results in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l fuzzing-failure-dir -d 'If given, store the failing input in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l fuzz-timeout -d 'Maximum time in seconds to spend fuzzing (default: 1 seconds)' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l fuzz-max-executions -d 'Maximum number of executions to run for each fuzz test (default: 100000)' -r
complete -c nargo -n "__fish_nargo_using_subcommand test" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand test" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-output -d 'Display output of `println` statements'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l exact -d 'Only run tests that match exactly'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l list-tests -d 'Print all matching test names'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand test" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand test" -s q -l quiet -d 'Display one character per test instead of one line'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l no-fuzz -d 'Do not run fuzz tests (tests that have arguments)'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l only-fuzz -d 'Only run fuzz tests (tests that have arguments)'
complete -c nargo -n "__fish_nargo_using_subcommand test" -l fuzz-show-progress -d 'Show progress of fuzzing (default: false)'
complete -c nargo -n "__fish_nargo_using_subcommand test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l test-threads -d 'Number of threads used for running tests in parallel' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l format -d 'Configure formatting of output' -r -f -a "pretty\t'Print verbose output'
terse\t'Display one character per test'
json\t'Output a JSON Lines document'"
complete -c nargo -n "__fish_nargo_using_subcommand t" -l corpus-dir -d 'If given, load/store fuzzer corpus from this folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l minimized-corpus-dir -d 'If given, perform corpus minimization instead of fuzzing and store results in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l fuzzing-failure-dir -d 'If given, store the failing input in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l fuzz-timeout -d 'Maximum time in seconds to spend fuzzing (default: 1 seconds)' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l fuzz-max-executions -d 'Maximum number of executions to run for each fuzz test (default: 100000)' -r
complete -c nargo -n "__fish_nargo_using_subcommand t" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand t" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-output -d 'Display output of `println` statements'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l exact -d 'Only run tests that match exactly'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l list-tests -d 'Print all matching test names'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand t" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand t" -s q -l quiet -d 'Display one character per test instead of one line'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l no-fuzz -d 'Do not run fuzz tests (tests that have arguments)'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l only-fuzz -d 'Only run fuzz tests (tests that have arguments)'
complete -c nargo -n "__fish_nargo_using_subcommand t" -l fuzz-show-progress -d 'Show progress of fuzzing (default: false)'
complete -c nargo -n "__fish_nargo_using_subcommand t" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l corpus-dir -d 'If given, load/store fuzzer corpus from this folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l minimized-corpus-dir -d 'If given, perform corpus minimization instead of fuzzing and store results in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l fuzzing-failure-dir -d 'If given, store the failing input in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l num-threads -d 'The number of threads to use for fuzzing' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l timeout -d 'Maximum time in seconds to spend fuzzing (default: no timeout)' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l max-executions -d 'Maximum number of executions of ACIR and Brillig per harness (default: no limit)' -r
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l list-all -d 'List all available harnesses that match the name'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-output -d 'Display output of `println` statements'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l exact -d 'Only run harnesses that match exactly'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand fuzz" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l corpus-dir -d 'If given, load/store fuzzer corpus from this folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l minimized-corpus-dir -d 'If given, perform corpus minimization instead of fuzzing and store results in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l fuzzing-failure-dir -d 'If given, store the failing input in the given folder' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l num-threads -d 'The number of threads to use for fuzzing' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l oracle-resolver -d 'JSON RPC url to solve oracle calls' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l timeout -d 'Maximum time in seconds to spend fuzzing (default: no timeout)' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l max-executions -d 'Maximum number of executions of ACIR and Brillig per harness (default: no limit)' -r
complete -c nargo -n "__fish_nargo_using_subcommand f" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand f" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand f" -l list-all -d 'List all available harnesses that match the name'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-output -d 'Display output of `println` statements'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l exact -d 'Only run harnesses that match exactly'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand f" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand f" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand f" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -s p -l prover-name -d 'The name of the toml file which contains the inputs for the prover' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand info" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand info" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand info" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l json -d 'Output a JSON formatted report. Changes to this format are not currently considered breaking'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l profile-execution
complete -c nargo -n "__fish_nargo_using_subcommand info" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand info" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand info" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand info" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -s p -l prover-name -d 'The name of the toml file which contains the inputs for the prover' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand i" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand i" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand i" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l json -d 'Output a JSON formatted report. Changes to this format are not currently considered breaking'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l profile-execution
complete -c nargo -n "__fish_nargo_using_subcommand i" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand i" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand i" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand i" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand lsp" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand lsp" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand lsp" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l expression-width -d 'Override the expression width requested by the backend' -r
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-project-folder -r
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-package -r
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-prover-name -r
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-test-name -r
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-check
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-generate-acir
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l preflight-skip-instrumentation
complete -c nargo -n "__fish_nargo_using_subcommand dap" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand dap" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l package -d 'The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l expression-width -d 'Specify the backend expression width that should be targeted' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-ssa-pass -d 'Only show SSA passes whose name contains the provided string. This setting takes precedence over `show_ssa` if it\'s not empty' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-contract-fn -d 'Only show the SSA and ACIR for the contract function with a given name' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l skip-ssa-pass -d 'Skip SSA passes whose name contains the provided string(s)' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l debug-comptime-in-file -d 'Enable printing results of comptime evaluation: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l inliner-aggressiveness -d 'Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l constant-folding-max-iter -d 'Maximum number of iterations to do in constant folding, as long as new values are being hoisted. A value of 0 effectively disables constant folding' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l small-function-max-instructions -d 'Setting to decide the maximum weight threshold at which we designate a function as "small" and thus to always be inlined' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l max-bytecode-increase-percent -d 'Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -s Z -l unstable-features -d 'Unstable features to enable for this current build' -r
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l workspace -d 'Run on all packages in the workspace'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l bounded-codegen -d 'Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l force -d 'Force a full recompilation'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-ssa -d 'Emit debug information for the intermediate SSA IR to stdout'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l with-ssa-locations -d 'Emit source file locations when emitting debug information for the SSA IR to stdout. By default, source file locations won\'t be shown'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l emit-ssa -d 'Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under `[compiled-package].ssa.json`'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l minimal-ssa -d 'Only perform the minimum number of SSA passes'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-brillig
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l print-acir -d 'Display the ACIR for compiled circuit'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l benchmark-codegen -d 'Pretty print benchmark times of each code generation pass'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l deny-warnings -d 'Treat all warnings as errors'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l silence-warnings -d 'Suppress warnings'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-monomorphized -d 'Outputs the monomorphized IR to stdout for debugging'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l instrument-debug -d 'Insert debug symbols to inspect variables'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l force-brillig -d 'Force Brillig output (for step debugging)'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l show-artifact-paths -d 'Outputs the paths to any modified artifacts'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l skip-underconstrained-check -d 'Flag to turn off the compiler check for under constrained values. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l skip-brillig-constraints-check -d 'Flag to turn off the compiler check for missing Brillig call constraints. Warning: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l enable-brillig-debug-assertions -d 'Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l count-array-copies -d 'Count the number of arrays that are copied in an unconstrained context for performance debugging'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l enable-brillig-constraints-check-lookback -d 'Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l pedantic-solving -d 'Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l debug-compile-stdin -d 'Skip reading files/folders from the root directory and instead accept the contents of `main.nr` through STDIN'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l no-unstable-features -d 'Disable any unstable features required in crate manifests'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -l disable-comptime-printing -d 'Used internally to avoid comptime println from producing output'
complete -c nargo -n "__fish_nargo_using_subcommand expand" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c nargo -n "__fish_nargo_using_subcommand generate-completion-script" -l program-dir -r -F
complete -c nargo -n "__fish_nargo_using_subcommand generate-completion-script" -l target-dir -d 'Override the default target directory' -r -F
complete -c nargo -n "__fish_nargo_using_subcommand generate-completion-script" -s h -l help -d 'Print help'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "check" -d 'Check a local package and all of its dependencies for errors'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "fmt" -d 'Format the Noir files in a workspace'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "compile" -d 'Compile the program and its secret execution trace into ACIR format'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "interpret" -d 'Compile the program and interpret the SSA after each pass, printing the results to the console'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "new" -d 'Create a Noir project in a new directory'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "init" -d 'Create a Noir project in the current directory'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "execute" -d 'Executes a circuit to calculate its return value'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "export" -d 'Exports functions marked with #[export] attribute'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "debug" -d 'Executes a circuit in debug mode'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "test" -d 'Run the tests for this program'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "fuzz" -d 'Run the fuzzing harnesses for this program'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "info" -d 'Provides detailed information on each of a program\'s function (represented by a single circuit)'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "lsp" -d 'Starts the Noir LSP server'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "dap"
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "expand" -d 'Show the result of macro expansion'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "generate-completion-script" -d 'Generates a shell completion script for your favorite shell'
complete -c nargo -n "__fish_nargo_using_subcommand help; and not __fish_seen_subcommand_from check fmt compile interpret new init execute export debug test fuzz info lsp dap expand generate-completion-script help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
