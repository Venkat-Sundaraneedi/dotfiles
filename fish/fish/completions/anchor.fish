function __fish_anchor_global_optspecs
	string join \n provider.cluster= provider.wallet= commitment= h/help V/version
end

function __fish_anchor_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_anchor_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_anchor_using_subcommand
	set -l cmd (__fish_anchor_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c anchor -n "__fish_anchor_needs_command" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_needs_command" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_needs_command" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_needs_command" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_needs_command" -s V -l version -d 'Print version'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "init" -d 'Initializes a workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "build" -d 'Builds the workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "expand" -d 'Expands macros (wrapper around cargo expand)'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "verify" -d 'Verifies the on-chain bytecode matches the locally compiled artifact. Run this command inside a program subdirectory, i.e., in the dir containing the program\'s Cargo.toml'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "test" -d 'Runs integration tests'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "new" -d 'Creates a new program'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "idl" -d 'Commands for interacting with interface definitions'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "clean" -d 'Remove all artifacts from the generated directories except program keypairs'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "deploy" -d 'Deploys each program in the workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "migrate" -d 'Runs the deploy migration script'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "upgrade" -d 'Deploys, initializes an IDL, and migrates all in one command. Upgrades a single program. The configured wallet must be the upgrade authority'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "airdrop" -d 'Request an airdrop of SOL'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "cluster" -d 'Cluster commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "config" -d 'Configuration management commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "shell" -d 'Starts a node shell with an Anchor client setup according to the local config'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "run" -d 'Runs the script defined by the current workspace\'s Anchor.toml'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "login" -d 'Saves an api token from the registry locally'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "keys" -d 'Program keypair commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "localnet" -d 'Localnet commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "account" -d 'Fetch and deserialize an account using the IDL provided'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "completions" -d 'Generates shell completions'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "address" -d 'Get your public key'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "balance" -d 'Get your balance'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "epoch" -d 'Get current epoch'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "epoch-info" -d 'Get information about the current epoch'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "logs" -d 'Stream transaction logs'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "show-account" -d 'Show the contents of an account'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "keygen" -d 'Keypair generation and management'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "program" -d 'Program deployment and management commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l package-manager -d 'Package Manager to use' -r -f -a "{npm\t'Use npm as the package manager',yarn\t'Use yarn as the package manager',pnpm\t'Use pnpm as the package manager',bun\t'Use bun as the package manager'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -s t -l template -d 'Rust program template to use' -r -f -a "{single\t'Program with a single `lib.rs` file (not recommended for production)',multiple\t'Program with multiple files for instructions, state... (recommended)'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -l test-template -d 'Test template to use' -r -f -a "{mocha\t'Generate template for Mocha unit-test',jest\t'Generate template for Jest unit-test',rust\t'Generate template for Rust unit-test',mollusk\t'Generate template for Mollusk Rust unit-test'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand init" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand init" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand init" -s j -l javascript -d 'Use JavaScript instead of TypeScript'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l no-install -d 'Don\'t install JavaScript dependencies'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l no-git -d 'Don\'t initialize git'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l force -d 'Initialize even if there are files'
complete -c anchor -n "__fish_anchor_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s i -l idl -d 'Output directory for the IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s t -l idl-ts -d 'Output directory for the TypeScript IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s p -l program-name -d 'Name of the program to build' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s s -l solana-version -d 'Version of the Solana toolchain to use. For --verifiable builds only' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s d -l docker-image -d 'Docker image to use. For --verifiable builds only' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s b -l bootstrap -d 'Bootstrap docker image from scratch, installing all requirements for verifiable builds. Only works for debian-based images' -r -f -a "{none\t'',debian\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand build" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand build" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments'
complete -c anchor -n "__fish_anchor_using_subcommand build" -l ignore-keys -d 'Skip checking for program ID mismatch between keypair and declare_id'
complete -c anchor -n "__fish_anchor_using_subcommand build" -l no-idl -d 'Do not build the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s v -l verifiable -d 'True if the build artifact needs to be deterministic and verifiable'
complete -c anchor -n "__fish_anchor_using_subcommand build" -l no-docs -d 'Suppress doc strings in IDL output'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand expand" -s p -l program-name -d 'Expand only this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l repo-url -d 'The URL of the repository to verify against. Conflicts with `--current-dir`' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l commit-hash -d 'The commit hash to verify against. Requires `--repo-url`' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l program-name -d 'Name of the program to run the command on. Defaults to the package name' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l current-dir -d 'Verify against the source code in the current directory. Conflicts with `--repo-url`'
complete -c anchor -n "__fish_anchor_using_subcommand verify" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand test" -s p -l program-name -d 'Build and test only this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand test" -l run -d 'Run the test suites under the specified path' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-deploy -d 'Use this flag if you want to run tests against previously deployed programs'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments where normally required'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-local-validator -d 'Flag to skip starting a local validator, if the configured cluster url is a localnet'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-build -d 'Flag to skip building the program in the workspace, use this to save time when running test and the program code is not altered'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l no-idl -d 'Do not build the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l detach -d 'Flag to keep the local validator running after tests to be able to check the transactions'
complete -c anchor -n "__fish_anchor_using_subcommand test" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand new" -s t -l template -d 'Rust program template to use' -r -f -a "{single\t'Program with a single `lib.rs` file (not recommended for production)',multiple\t'Program with multiple files for instructions, state... (recommended)'}"
complete -c anchor -n "__fish_anchor_using_subcommand new" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand new" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand new" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand new" -l force -d 'Create new program even if there is already one'
complete -c anchor -n "__fish_anchor_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "close" -d 'Close a metadata account and recover rent'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "create-buffer" -d 'Create a buffer account for metadata'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "set-buffer-authority" -d 'Set a new authority on a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "write-buffer" -d 'Write metadata using a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init upgrade build fetch convert type close create-buffer set-buffer-authority write-buffer help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -s f -l filepath -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l non-canonical -d 'Create non-canonical metadata account (third-party metadata)'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -s f -l filepath -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s p -l program-name -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s t -l out-ts -d 'Output file for the TypeScript IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l no-docs -d 'Suppress doc strings in output'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l skip-lint -d 'Do not check for safety comments'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l non-canonical -d 'Fetch non-canonical metadata account (third-party metadata)'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s p -l program-id -d 'Address to use (defaults to `metadata.address` value)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l seed -d 'The seed used for the metadata account (default: "idl")' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l priority-fee -d 'Priority fees in micro-lamports per compute unit' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -s f -l filepath -d 'Path to the metadata file' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -l priority-fee -d 'Priority fees in micro-lamports per compute unit' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from create-buffer" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -s n -l new-authority -d 'The new authority' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -l priority-fee -d 'Priority fees in micro-lamports per compute unit' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer-authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -s b -l buffer -d 'The buffer account address' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l seed -d 'The seed to use for the metadata account (default: "idl")' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l priority-fee -d 'Priority fees in micro-lamports per compute unit' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l close-buffer -d 'Close the buffer after writing'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "close" -d 'Close a metadata account and recover rent'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "create-buffer" -d 'Create a buffer account for metadata'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "set-buffer-authority" -d 'Set a new authority on a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "write-buffer" -d 'Write metadata using a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand clean" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand clean" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand clean" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand clean" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s p -l program-name -d 'Only deploy this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l program-keypair -d 'Keypair of the program (filepath) (requires program-name)' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s v -l verifiable -d 'If true, deploy from path target/verifiable'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l no-idl -d 'Don\'t upload IDL during deployment (IDL is uploaded by default)'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -s p -l program-id -d 'The program to upgrade' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l max-retries -d 'Max times to retry on failure' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand airdrop" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand airdrop" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand airdrop" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand airdrop" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from help" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -f -a "get" -d 'Get configuration settings from the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -f -a "set" -d 'Set configuration settings in the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand config; and not __fish_seen_subcommand_from get set help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from get" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from get" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from get" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -s u -l url -d 'Cluster to connect to (custom URL). Use -um, -ud, -ut, -ul for standard clusters' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -s k -l keypair -d 'Path to wallet keypair file to update the Anchor.toml file with' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get configuration settings from the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "set" -d 'Set configuration settings in the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand shell" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand shell" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand shell" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand shell" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand run" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand run" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand run" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand run" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand login" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand login" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand login" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand login" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -s p -l program-name -d 'Only sync the given program instead of all programs' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-build -d 'Flag to skip building the program in the workspace, use this to save time when running test and the program code is not altered'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-deploy -d 'Use this flag if you want to run tests against previously deployed programs'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments where normally required'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l ignore-keys -d 'Skip checking for program ID mismatch between keypair and declare_id'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand account" -l idl -d 'IDL to use (defaults to workspace IDL)' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand completions" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand completions" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand completions" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand completions" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand address" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand address" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand address" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand address" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand balance" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand balance" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand balance" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand balance" -l lamports -d 'Display balance in lamports instead of SOL'
complete -c anchor -n "__fish_anchor_using_subcommand balance" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand epoch" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand epoch-info" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch-info" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch-info" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand epoch-info" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand logs" -l address -d 'Addresses to filter logs by' -r
complete -c anchor -n "__fish_anchor_using_subcommand logs" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand logs" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand logs" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand logs" -l include-votes -d 'Include vote transactions when monitoring all transactions'
complete -c anchor -n "__fish_anchor_using_subcommand logs" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -s o -l output-file -d 'Write the account data to this file' -r -F
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -l output -d 'Return information in specified output format' -r -f -a "{json\t'',json-compact\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -l lamports -d 'Display balance in lamports instead of SOL'
complete -c anchor -n "__fish_anchor_using_subcommand show-account" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -f -a "new" -d 'Generate a new keypair'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -f -a "pubkey" -d 'Display the pubkey for a given keypair'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -f -a "recover" -d 'Recover a keypair from a seed phrase'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -f -a "verify" -d 'Verify a keypair can sign and verify a message'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and not __fish_seen_subcommand_from new pubkey recover verify help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -s o -l outfile -d 'Path to generated keypair file' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -s w -l word-count -d 'Number of words in the mnemonic phrase [possible values: 12, 15, 18, 21, 24]' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -s f -l force -d 'Overwrite the output file if it exists'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -l no-passphrase -d 'Do not prompt for a passphrase'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -l silent -d 'Do not display the generated pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from pubkey" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from pubkey" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from pubkey" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from pubkey" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -s o -l outfile -d 'Path to recovered keypair file' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -s f -l force -d 'Overwrite the output file if it exists'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -l skip-seed-phrase-validation -d 'Skip seed phrase validation'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -l no-passphrase -d 'Do not prompt for a passphrase'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from recover" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from verify" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from verify" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from verify" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from help" -f -a "new" -d 'Generate a new keypair'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from help" -f -a "pubkey" -d 'Display the pubkey for a given keypair'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from help" -f -a "recover" -d 'Recover a keypair from a seed phrase'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from help" -f -a "verify" -d 'Verify a keypair can sign and verify a message'
complete -c anchor -n "__fish_anchor_using_subcommand keygen; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "deploy" -d 'Deploy an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "write-buffer" -d 'Write a program into a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "set-buffer-authority" -d 'Set a new buffer authority'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "set-upgrade-authority" -d 'Set a new program authority'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "show" -d 'Display information about a buffer or program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "upgrade" -d 'Upgrade an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "dump" -d 'Write the program data to a file'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "close" -d 'Close a program or buffer account and withdraw all lamports'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "extend" -d 'Extend the length of an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and not __fish_seen_subcommand_from deploy write-buffer set-buffer-authority set-upgrade-authority show upgrade dump close extend help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -s p -l program-name -d 'Program name to deploy (from workspace). Used when program_filepath is not provided' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l program-keypair -d 'Program keypair filepath (defaults to target/deploy/{program_name}-keypair.json)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l upgrade-authority -d 'Upgrade authority keypair (defaults to configured wallet)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l program-id -d 'Program id to deploy to (derived from program-keypair if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l buffer -d 'Buffer account to use for deployment' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l max-len -d 'Maximum transaction length (BPF loader upgradeable limit)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l no-idl -d 'Don\'t upload IDL during deployment (IDL is uploaded by default)'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -l final -d 'Make the program immutable after deployment (cannot be upgraded)'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from deploy" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -s p -l program-name -d 'Program name to write (from workspace). Used when program_filepath is not provided' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l buffer -d 'Buffer account keypair (defaults to new keypair)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l buffer-authority -d 'Buffer authority (defaults to configured wallet)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l max-len -d 'Maximum transaction length' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from write-buffer" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-buffer-authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-buffer-authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-buffer-authority" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-buffer-authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l new-upgrade-authority -d 'New upgrade authority pubkey' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l new-upgrade-authority-signer -d 'New upgrade authority signer (keypair file). Required unless --skip-new-upgrade-authority-signer-check is used. When provided, both current and new authority will sign (checked mode, recommended)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l upgrade-authority -d 'Current upgrade authority keypair (defaults to configured wallet)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l skip-new-upgrade-authority-signer-check -d 'Skip new upgrade authority signer check. Allows setting authority with only current authority signature. WARNING: Less safe - use only if you\'re confident the pubkey is correct'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -l final -d 'Make the program immutable (cannot be upgraded)'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from set-upgrade-authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l get-programs -d 'Get account information from the Solana config file'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l get-buffers -d 'Get account information from the Solana config file'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -l all -d 'Show all accounts'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l program-filepath -d 'Program filepath (e.g., target/deploy/my_program.so). If not provided, discovers from workspace' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -s p -l program-name -d 'Program name to upgrade (from workspace). Used when program_filepath is not provided' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l buffer -d 'Existing buffer account to upgrade from. If not provided, auto-discovers program from workspace' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l upgrade-authority -d 'Upgrade authority (defaults to configured wallet)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l max-retries -d 'Max times to retry on failure' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from upgrade" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from dump" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from dump" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from dump" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -s p -l program-name -d 'Program name to close (from workspace). Used when account is not provided' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l authority -d 'Authority keypair (defaults to configured wallet)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l recipient -d 'Recipient address for reclaimed lamports (defaults to authority)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -l bypass-warning -d 'Bypass warning prompts'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from close" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from extend" -s p -l program-name -d 'Program name to extend (from workspace). Used when program_id is not provided' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from extend" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from extend" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from extend" -l commitment -d 'Commitment override (valid values: processed, confirmed, finalized)' -r
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from extend" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "deploy" -d 'Deploy an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "write-buffer" -d 'Write a program into a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "set-buffer-authority" -d 'Set a new buffer authority'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "set-upgrade-authority" -d 'Set a new program authority'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "show" -d 'Display information about a buffer or program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "upgrade" -d 'Upgrade an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Write the program data to a file'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "close" -d 'Close a program or buffer account and withdraw all lamports'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "extend" -d 'Extend the length of an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand program; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "init" -d 'Initializes a workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "build" -d 'Builds the workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "expand" -d 'Expands macros (wrapper around cargo expand)'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "verify" -d 'Verifies the on-chain bytecode matches the locally compiled artifact. Run this command inside a program subdirectory, i.e., in the dir containing the program\'s Cargo.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "test" -d 'Runs integration tests'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "new" -d 'Creates a new program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "idl" -d 'Commands for interacting with interface definitions'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "clean" -d 'Remove all artifacts from the generated directories except program keypairs'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "deploy" -d 'Deploys each program in the workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "migrate" -d 'Runs the deploy migration script'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "upgrade" -d 'Deploys, initializes an IDL, and migrates all in one command. Upgrades a single program. The configured wallet must be the upgrade authority'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "airdrop" -d 'Request an airdrop of SOL'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "cluster" -d 'Cluster commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "config" -d 'Configuration management commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "shell" -d 'Starts a node shell with an Anchor client setup according to the local config'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "run" -d 'Runs the script defined by the current workspace\'s Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "login" -d 'Saves an api token from the registry locally'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "keys" -d 'Program keypair commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "localnet" -d 'Localnet commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "account" -d 'Fetch and deserialize an account using the IDL provided'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "completions" -d 'Generates shell completions'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "address" -d 'Get your public key'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "balance" -d 'Get your balance'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "epoch" -d 'Get current epoch'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "epoch-info" -d 'Get information about the current epoch'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "logs" -d 'Stream transaction logs'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "show-account" -d 'Show the contents of an account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "keygen" -d 'Keypair generation and management'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "program" -d 'Program deployment and management commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade airdrop cluster config shell run login keys localnet account completions address balance epoch epoch-info logs show-account keygen program help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "close" -d 'Close a metadata account and recover rent'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "create-buffer" -d 'Create a buffer account for metadata'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "set-buffer-authority" -d 'Set a new authority on a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "write-buffer" -d 'Write metadata using a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from cluster" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "get" -d 'Get configuration settings from the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "set" -d 'Set configuration settings in the local Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keys" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keys" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keygen" -f -a "new" -d 'Generate a new keypair'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keygen" -f -a "pubkey" -d 'Display the pubkey for a given keypair'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keygen" -f -a "recover" -d 'Recover a keypair from a seed phrase'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keygen" -f -a "verify" -d 'Verify a keypair can sign and verify a message'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "deploy" -d 'Deploy an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "write-buffer" -d 'Write a program into a buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "set-buffer-authority" -d 'Set a new buffer authority'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "set-upgrade-authority" -d 'Set a new program authority'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "show" -d 'Display information about a buffer or program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "upgrade" -d 'Upgrade an upgradeable program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "dump" -d 'Write the program data to a file'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "close" -d 'Close a program or buffer account and withdraw all lamports'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from program" -f -a "extend" -d 'Extend the length of an upgradeable program'
