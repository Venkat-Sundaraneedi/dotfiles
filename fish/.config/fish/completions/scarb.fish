# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_scarb_global_optspecs
	string join \n manifest-path= v/verbose q/quiet no-warnings verbosity= json offline global-cache-dir= global-config-dir= target-dir= no-proc-macros no-prebuilt-proc-macros P/profile= release dev h/help V/version
end

function __fish_scarb_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_scarb_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_scarb_using_subcommand
	set -l cmd (__fish_scarb_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c scarb -n "__fish_scarb_needs_command" -l manifest-path -d 'Path to Scarb.toml' -r
complete -c scarb -n "__fish_scarb_needs_command" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_needs_command" -l global-cache-dir -d 'Directory for all cache data stored by Scarb' -r
complete -c scarb -n "__fish_scarb_needs_command" -l global-config-dir -d 'Directory for global Scarb configuration files' -r
complete -c scarb -n "__fish_scarb_needs_command" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c scarb -n "__fish_scarb_needs_command" -s P -l profile -d 'Specify the profile to use by name' -r
complete -c scarb -n "__fish_scarb_needs_command" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_needs_command" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_needs_command" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_needs_command" -l json -d 'Print machine-readable output in NDJSON format'
complete -c scarb -n "__fish_scarb_needs_command" -l offline -d 'Run without accessing the network'
complete -c scarb -n "__fish_scarb_needs_command" -l no-proc-macros -d 'Do not load any procedural macros'
complete -c scarb -n "__fish_scarb_needs_command" -l no-prebuilt-proc-macros -d 'Do not load any prebuilt procedural macros'
complete -c scarb -n "__fish_scarb_needs_command" -l release -d 'Use release profile'
complete -c scarb -n "__fish_scarb_needs_command" -l dev -d 'Use dev profile'
complete -c scarb -n "__fish_scarb_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_needs_command" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "add" -d 'Add dependencies to a Scarb.toml manifest file'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "remove" -d 'Remove dependencies from a manifest file'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "build" -d 'Compile current project'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "expand" -d 'Expand macros'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "cache" -d 'Manipulate packages cache'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "check" -d 'Analyze the current package and report errors, but don\'t build Sierra files'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "clean" -d 'Remove generated artifacts'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "completions" -d 'Generate shell completions for Scarb'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "commands" -d 'List installed commands'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "fetch" -d 'Fetch dependencies of packages from the network'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "fmt" -d 'Format project files'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "init" -d 'Create a new Scarb package in the existing directory'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "manifest-path" -d 'Print a path to the current Scarb.toml file to standard output'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "metadata" -d 'Output the resolved dependencies of a package, the concrete versions used, including overrides, in machine-readable format'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "new" -d 'Create a new Scarb package at PATH'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "tree" -d 'Display a tree visualisation of a dependency graph'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "package" -d 'Assemble the local package into a distributable tarball'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "proc-macro-server" -d 'Start the proc macro server'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "publish" -d 'Upload a package to the registry'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "lint" -d 'Checks a package to catch common mistakes and improve your Cairo code'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "run" -d 'Run arbitrary package scripts'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "test" -d 'Execute all unit and integration tests of a local package'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "update" -d 'Update dependencies'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "cairo-language-server" -d 'Start the Cairo Language Server'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "cairo-test" -d 'Execute all unit tests of a local package'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "prove" -d 'Prove `scarb execute` output using Stwo prover.'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "mdbook" -d 'Build `mdBook` documentation'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "cairo-run" -d 'Execute the main function of a package'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "doc" -d 'Generate documentation based on code comments'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "verify" -d 'Verify `scarb prove` output using Stwo verifier'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "execute" -d 'Compile a Cairo project and run a function marked `#[executable]`'
complete -c scarb -n "__fish_scarb_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c scarb -n "__fish_scarb_using_subcommand add" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l path -d 'Filesystem path to local package to add' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l git -d 'Git repository location' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l branch -d 'Git branch to download the package from' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l tag -d 'Git tag to download the package from' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l rev -d 'Git reference to download the package from' -r
complete -c scarb -n "__fish_scarb_using_subcommand add" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand add" -l dry-run -d 'Do not actually write the manifest'
complete -c scarb -n "__fish_scarb_using_subcommand add" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand add" -l dev -d 'Add as development dependency'
complete -c scarb -n "__fish_scarb_using_subcommand add" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand add" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand add" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand remove" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand remove" -l dry-run -d 'Do not actually write the manifest'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -l dev -d 'Remove as development dependency'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand remove" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand build" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand build" -l target-names -d 'Comma separated list of target names to compile' -r
complete -c scarb -n "__fish_scarb_using_subcommand build" -l target-kinds -d 'Comma separated list of target kinds to compile' -r
complete -c scarb -n "__fish_scarb_using_subcommand build" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand build" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand build" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand build" -s t -l test -d 'Build tests'
complete -c scarb -n "__fish_scarb_using_subcommand build" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand build" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand build" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand build" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand build" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand build" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l target-kind -d 'Specify the target to expand by target kind' -r
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l target-name -d 'Specify the target to expand by target name' -r
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s e -l emit -d 'Emit the expanded file to stdout' -r -f -a "stdout\t''"
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l ugly -d 'Do not attempt formatting'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand expand" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -f -a "clean" -d 'Remove all cached dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -f -a "path" -d 'Print the path of the cache directory'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and not __fish_seen_subcommand_from clean path help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from clean" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from clean" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from clean" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from clean" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from clean" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from path" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from path" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from path" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from path" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from path" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from help" -f -a "clean" -d 'Remove all cached dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from help" -f -a "path" -d 'Print the path of the cache directory'
complete -c scarb -n "__fish_scarb_using_subcommand cache; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c scarb -n "__fish_scarb_using_subcommand check" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand check" -l target-names -d 'Comma separated list of target names to compile' -r
complete -c scarb -n "__fish_scarb_using_subcommand check" -l target-kinds -d 'Comma separated list of target kinds to compile' -r
complete -c scarb -n "__fish_scarb_using_subcommand check" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand check" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand check" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand check" -s t -l test -d 'Build tests'
complete -c scarb -n "__fish_scarb_using_subcommand check" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand check" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand check" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand check" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand check" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand check" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand clean" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand clean" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand clean" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand clean" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand clean" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand completions" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand completions" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand completions" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand completions" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand completions" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand commands" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand commands" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand commands" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand commands" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand commands" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand fetch" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand fetch" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand fetch" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand fetch" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand fetch" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s e -l emit -d 'Emit the formatted file to stdout' -r -f -a "stdout\t''"
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s c -l check -d 'Only check if files are formatted, do not write the changes to disk'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -l no-color -d 'Do not color output'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand fmt" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand init" -l name -d 'Set the resulting package name, defaults to the directory name' -r
complete -c scarb -n "__fish_scarb_using_subcommand init" -l test-runner -d 'Test runner to use. Starts interactive session if not specified' -r -f -a "starknet-foundry\t'Uses the `Starknet Foundry` test runner'
cairo-test\t'Uses the Cairo Test test runner'"
complete -c scarb -n "__fish_scarb_using_subcommand init" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand init" -l no-vcs -d 'Do not initialize a new Git repository'
complete -c scarb -n "__fish_scarb_using_subcommand init" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand init" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand init" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand manifest-path" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand manifest-path" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand manifest-path" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand manifest-path" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand manifest-path" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l format-version -d 'Format version' -r
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l no-deps -d 'Output information only about the workspace members and don\'t fetch dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand metadata" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand new" -l name -d 'Set the resulting package name, defaults to the directory name' -r
complete -c scarb -n "__fish_scarb_using_subcommand new" -l test-runner -d 'Test runner to use. Starts interactive session if not specified' -r -f -a "starknet-foundry\t'Uses the `Starknet Foundry` test runner'
cairo-test\t'Uses the Cairo Test test runner'"
complete -c scarb -n "__fish_scarb_using_subcommand new" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand new" -l no-vcs -d 'Do not initialize a new Git repository'
complete -c scarb -n "__fish_scarb_using_subcommand new" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand new" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand new" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l prune -d 'Prune the given package(s) from the display of the dependency tree' -r
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l depth -d 'Maximum display depth of the dependency tree' -r
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand tree" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l no-dedupe -d 'Do not de-duplicate repeated dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l core -d 'Include the `core` package in the dependency tree'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand tree" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand package" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand package" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand package" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand package" -s l -l list -d 'Print files included in a package without making one'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l no-metadata -d 'Ignore warnings about a lack of human-usable metadata'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l allow-dirty -d 'Allow working directories with uncommitted VCS changes to be packaged'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l no-verify -d 'Do not verify the contents by building them'
complete -c scarb -n "__fish_scarb_using_subcommand package" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand package" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand package" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand package" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand package" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand proc-macro-server" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand proc-macro-server" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand proc-macro-server" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand proc-macro-server" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand proc-macro-server" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l index -d 'Registry index URL to upload the package to' -r
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l allow-dirty -d 'Allow working directories with uncommitted VCS changes to be packaged'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l no-verify -d 'Do not verify the contents by building them'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand publish" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l target-names -d 'Comma separated list of target names to compile' -r
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s t -l test -d 'Should lint the tests'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s f -l fix -d 'Should fix the lint when it can'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l ignore-cairo-version -d 'Do not error on `cairo-version` mismatch'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s d -l deny-warnings -d 'Should fail on any warning'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand lint" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand run" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand run" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand run" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand run" -l workspace-root -d 'Run the script in workspace root only'
complete -c scarb -n "__fish_scarb_using_subcommand run" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand run" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand run" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand run" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand test" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand test" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand test" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand test" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand test" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand test" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand test" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand test" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand test" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand update" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand update" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand update" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand update" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s f -l filter -d 'Run only tests whose name contain FILTER' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s t -l test-kind -d 'Choose test kind to run' -r -f -a "unit\t'Run only unit tests'
integration\t'Run only integration tests'
all\t'Run all tests'"
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -l include-ignored -d 'Run ignored and not ignored tests'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -l ignored -d 'Run only ignored tests'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -l print-resource-usage -d 'Whether to print resource usage after each test'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-test" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l execution-id -d 'ID of `scarb execute` *standard* output for given package, for which to generate proof' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l executable-name -d 'Choose build target to run by target name' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l executable-function -d 'Choose build target to run by function path' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l arguments -d 'Serialized arguments to the executable function' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l arguments-file -d 'Serialized arguments to the executable function from a file' -r
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l output -d 'Desired execution output, either default Standard or CairoPie' -r -f -a "cairo-pie\t'Output in Cairo PIE (Program Independent Execution) format'
standard\t'Output in standard format'
none\t'No output'"
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l target -d 'Execution target' -r -f -a "bootloader\t'Bootloader target'
standalone\t'Standalone target'"
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l execute -d 'Execute the program before proving'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l no-build -d 'Do not rebuild the package'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l print-program-output -d 'Whether to print the program outputs'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l print-resource-usage -d 'Whether to print detailed execution resources'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l experimental-oracles -d 'Enable experimental oracles support'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l track-relations -d 'Track relations during proving'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l display-components -d 'Display components during proving'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand prove" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -l input -d 'Path to book source directory' -r
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -l output -d 'Path to book output directory' -r
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand mdbook" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l function -d 'Specify name of the function to run' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l available-gas -d 'Maximum amount of gas available to the program' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l arguments-file -d 'Path to the JSON file containing program arguments' -r
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l print-full-memory -d 'Print more items in memory'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l print-resource-usage -d 'Print detailed resources'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l no-build -d 'Do not rebuild the package'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand cairo-run" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l output-format -d 'Specifies a format of generated files' -r -f -a "markdown\t'Generates documentation in Markdown format. Generated files are fully compatible with mdBook. For more information visit <https://rust-lang.github.io/mdBook>'
json\t'Saves information collected from packages in JSON format instead of generating documentation. This may be useful if you want to generate documentation files by yourself. The precise output structure is not guaranteed to be stable'"
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l document-private-items -d 'Generates documentation also for private items'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l build -d 'Build generated documentation'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand doc" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand verify" -l execution-id -d 'ID of `scarb execute` output for given package, for which proof was generated using `scarb prove`' -r
complete -c scarb -n "__fish_scarb_using_subcommand verify" -l proof-file -d 'Proof file path' -r
complete -c scarb -n "__fish_scarb_using_subcommand verify" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand verify" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s p -l package -d 'Packages to run this command on, can be a concrete package name (`foobar`) or a prefix glob (`foo*`)' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s F -l features -d 'Comma separated list of features to activate' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l executable-name -d 'Choose build target to run by target name' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l executable-function -d 'Choose build target to run by function path' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l arguments -d 'Serialized arguments to the executable function' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l arguments-file -d 'Serialized arguments to the executable function from a file' -r
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l output -d 'Desired execution output, either default Standard or CairoPie' -r -f -a "cairo-pie\t'Output in Cairo PIE (Program Independent Execution) format'
standard\t'Output in standard format'
none\t'No output'"
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l target -d 'Execution target' -r -f -a "bootloader\t'Bootloader target'
standalone\t'Standalone target'"
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l verbosity -d 'Set UI verbosity level by name.' -r -f -a "quiet\t'Avoid printing anything to standard output'
no-warnings\t'Avoid printing warnings to standard output'
normal\t'Default verbosity level'
verbose\t'Print extra information to standard output'"
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s w -l workspace -d 'Run for all packages in the workspace'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l no-build -d 'Do not rebuild the package'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l all-features -d 'Activate all available features'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l no-default-features -d 'Do not activate the `default` feature'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l print-program-output -d 'Whether to print the program outputs'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l print-resource-usage -d 'Whether to print detailed execution resources'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l experimental-oracles -d 'Enable experimental oracles support'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s v -l verbose -d 'Increase logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s q -l quiet -d 'Decrease logging verbosity.'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -l no-warnings -d 'Decrease logging verbosity, hiding warnings but still showing errors.'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c scarb -n "__fish_scarb_using_subcommand execute" -s V -l version -d 'Print version'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "add" -d 'Add dependencies to a Scarb.toml manifest file'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "remove" -d 'Remove dependencies from a manifest file'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "build" -d 'Compile current project'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "expand" -d 'Expand macros'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "cache" -d 'Manipulate packages cache'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "check" -d 'Analyze the current package and report errors, but don\'t build Sierra files'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "clean" -d 'Remove generated artifacts'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "completions" -d 'Generate shell completions for Scarb'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "commands" -d 'List installed commands'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "fetch" -d 'Fetch dependencies of packages from the network'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "fmt" -d 'Format project files'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "init" -d 'Create a new Scarb package in the existing directory'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "manifest-path" -d 'Print a path to the current Scarb.toml file to standard output'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "metadata" -d 'Output the resolved dependencies of a package, the concrete versions used, including overrides, in machine-readable format'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "new" -d 'Create a new Scarb package at PATH'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "tree" -d 'Display a tree visualisation of a dependency graph'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "package" -d 'Assemble the local package into a distributable tarball'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "proc-macro-server" -d 'Start the proc macro server'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "publish" -d 'Upload a package to the registry'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "lint" -d 'Checks a package to catch common mistakes and improve your Cairo code'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "run" -d 'Run arbitrary package scripts'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "test" -d 'Execute all unit and integration tests of a local package'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "update" -d 'Update dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "cairo-language-server" -d 'Start the Cairo Language Server'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "cairo-test" -d 'Execute all unit tests of a local package'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "prove" -d 'Prove `scarb execute` output using Stwo prover.'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "mdbook" -d 'Build `mdBook` documentation'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "cairo-run" -d 'Execute the main function of a package'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "doc" -d 'Generate documentation based on code comments'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "verify" -d 'Verify `scarb prove` output using Stwo verifier'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "execute" -d 'Compile a Cairo project and run a function marked `#[executable]`'
complete -c scarb -n "__fish_scarb_using_subcommand help; and not __fish_seen_subcommand_from add remove build expand cache check clean completions commands fetch fmt init manifest-path metadata new tree package proc-macro-server publish lint run test update cairo-language-server cairo-test prove mdbook cairo-run doc verify execute help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c scarb -n "__fish_scarb_using_subcommand help; and __fish_seen_subcommand_from cache" -f -a "clean" -d 'Remove all cached dependencies'
complete -c scarb -n "__fish_scarb_using_subcommand help; and __fish_seen_subcommand_from cache" -f -a "path" -d 'Print the path of the cache directory'
