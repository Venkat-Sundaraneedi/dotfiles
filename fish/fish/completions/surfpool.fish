# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_surfpool_global_optspecs
	string join \n h/help V/version
end

function __fish_surfpool_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_surfpool_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_surfpool_using_subcommand
	set -l cmd (__fish_surfpool_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c surfpool -n "__fish_surfpool_needs_command" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_needs_command" -s V -l version -d 'Print version'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "start" -d 'Start Simnet'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "completions" -d 'Generate shell completions scripts'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "run" -d 'Run, runbook, run!'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "ls" -d 'List runbooks present in the current direcoty'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "cloud" -d 'Txtx cloud commands'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "mcp" -d 'Start MCP server'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s m -l manifest-file-path -d 'Path to the runbook manifest, used to locate the root of the project (eg. surfpool start --manifest-file-path ./txtx.toml)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s p -l port -d 'Set the Simnet RPC port (eg. surfpool start --port 8080)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s w -l ws-port -d 'Set the Simnet WS port' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s o -l host -d 'Set the Simnet host address (eg. surfpool start --host 127.0.0.1)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s t -l slot-time -d 'Set the slot time (eg. surfpool start --slot-time 400)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s b -l block-production-mode -d 'Set the block production mode (eg. surfpool start --block-production-mode transaction)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s u -l rpc-url -d 'Set a datasource RPC URL (cannot be used with --network). Can also be set via SURFPOOL_DATASOURCE_RPC_URL. (eg. surfpool start --rpc-url https://api.mainnet-beta.solana.com)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s n -l network -d 'Choose a predefined network (cannot be used with --rpc-url) (eg. surfpool start --network mainnet)' -r -f -a "mainnet\t'Solana Mainnet-Beta (https://api.mainnet-beta.solana.com)'
devnet\t'Solana Devnet (https://api.devnet.solana.com)'
testnet\t'Solana Testnet (https://api.testnet.solana.com)'"
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s r -l runbook -d 'List of runbooks-id to run (eg. surfpool start --runbook runbook-1 --runbook runbook-2)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s a -l airdrop -d 'List of pubkeys to airdrop (eg. surfpool start --airdrop 5cQvx... --airdrop 5cQvy...)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s q -l airdrop-amount -d 'Quantity of tokens to airdrop' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s k -l airdrop-keypair-path -d 'List of keypair paths to airdrop (eg. surfpool start --airdrop-keypair-path ~/.config/solana/id.json --airdrop-keypair-path ~/.config/solana/id2.json)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s g -l geyser-plugin-config -d 'List of geyser plugins to load (eg. surfpool start --geyser-plugin-config plugin1.json --geyser-plugin-config plugin2.json)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s d -l subgraph-db -d 'Subgraph database connection URL (default to sqlite ":memory:", also supports postgres: "postgres://postgres:posgres@e127.0.0.1:5432/surfpool")' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s s -l studio-port -d 'Set the Studio port (eg. surfpool start --studio-port 8080)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s l -l log-level -d 'The log level to use for simnet logs. Options are "trace", "debug", "info", "warn", "error", or "none". (eg. surfpool start --log-level debug)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l log-path -d 'The directory to put simnet logs. (eg. surfpool start --log-path ./logs)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s c -l max-profiles -d 'The maximum number of transaction profiles to hold in memory. Changing this will affect the memory usage of surfpool. (eg. surfpool start --max-profiles 2000)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l log-bytes-limit -d 'The maximum number of bytes to allow in transaction logs. Set to 0 for unlimited. (eg. surfpool start --log-bytes-limit 64000)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l anchor-test-config-path -d 'Path to the Test.toml test suite files to load (eg. surfpool start --anchor-test-config-path ./path/to/Test.toml)' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-tui -d 'Display streams of logs instead of terminal UI dashboard(eg. surfpool start --no-tui)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l debug -d 'Include debug logs (eg. surfpool start --debug)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-deploy -d 'Disable auto deployments (eg. surfpool start --no-deploy)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s y -l yes -d 'Skip prompts for generating runbooks, and assume "yes" for all (eg. surfpool start -y)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l watch -d 'Watch programs in your `target/deploy` folder, and automatically re-execute the deployment runbook when the `.so` files change. (eg. surfpool start --watch)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-studio -d 'Disable Studio (eg. surfpool start --no-studio)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l offline -d 'Start surfpool without a remote RPC client to simulate an offline environment (eg. surfpool start --offline)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l disable-instruction-profiling -d 'Disable instruction profiling (eg. surfpool start --disable-instruction-profiling)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l daemon -d 'Start Surfpool as a background process (eg. surfpool start --daemon)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l ci -d 'Start surfpool with some CI adequate settings  (eg. surfpool start --ci)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l legacy-anchor-compatibility -d 'Apply suggested defaults for runbook generation and execution when running as part of an anchor test suite (eg. surfpool start --legacy-anchor-compatibility)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c surfpool -n "__fish_surfpool_using_subcommand completions" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s m -l manifest-file-path -d 'Path to the manifest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l output-json -d 'When running in unsupervised mode, print outputs in JSON format. If a directory is provided, the output will be written a file at the directory' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l output -d 'Pick a specific output to stdout at the end of the execution' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s p -l port -d 'Set the port for hosting the web UI' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s i -l ip -d 'Set the port for hosting the web UI' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l env -d 'Choose the environment variable to set from those configured in the txtx.yml' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l input -d 'A set of inputs to use for batch processing' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s l -l log-level -d 'The log level to use for the runbook execution. Options are "trace", "debug", "info", "warn", "error"' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l log-path -d 'The directory to put runbook execution logs' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s u -l unsupervised -d 'Execute the runbook without supervision'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s b -l browser -d 'Execute the runbook with supervision via the browser UI (this is the default execution mode)'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s t -l terminal -d 'Execute the runbook with supervision via the terminal console (coming soon)'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l explain -d 'Explain how the runbook will be executed'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s f -l force -d 'Execute the Runbook even if the cached state suggests this Runbook has already been executed'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand ls" -s m -l manifest-file-path -d 'Path to the manifest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand ls" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and not __fish_seen_subcommand_from login start help" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and not __fish_seen_subcommand_from login start help" -f -a "login" -d 'Login to the Txtx Cloud'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and not __fish_seen_subcommand_from login start help" -f -a "start" -d 'Start a new Cloud Surfnet instance'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and not __fish_seen_subcommand_from login start help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from login" -s e -l email -d 'The username to use for authentication' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from login" -s p -l password -d 'The password to use for authentication' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from login" -l pat -d 'Automatically log in using a Personal Access Token' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from login" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s w -l workspace -d 'The name of the workspace' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s n -l name -d 'The name of the surfnet that will be created' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s d -l description -d 'A description for the surfnet' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s u -l rpc-url -d 'The RPC url to use for the datasource' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s b -l block-production -d 'The block production mode for the surfnet. Options are `clock`, `transaction`, and `manual`' -r -f -a "clock\t''
transaction\t''
manual\t''"
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -l profile-transactions -d 'Enable cloud transaction profiling'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from help" -f -a "login" -d 'Login to the Txtx Cloud'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start a new Cloud Surfnet instance'
complete -c surfpool -n "__fish_surfpool_using_subcommand cloud; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c surfpool -n "__fish_surfpool_using_subcommand mcp" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "start" -d 'Start Simnet'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "completions" -d 'Generate shell completions scripts'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "run" -d 'Run, runbook, run!'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "ls" -d 'List runbooks present in the current direcoty'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "cloud" -d 'Txtx cloud commands'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "mcp" -d 'Start MCP server'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls cloud mcp help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and __fish_seen_subcommand_from cloud" -f -a "login" -d 'Login to the Txtx Cloud'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and __fish_seen_subcommand_from cloud" -f -a "start" -d 'Start a new Cloud Surfnet instance'
