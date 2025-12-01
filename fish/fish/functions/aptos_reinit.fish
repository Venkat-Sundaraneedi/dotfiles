function aptos_reinit
    # Delete .aptos directory
    rm -rf ./.aptos
    
    # Run aptos init with empty input to generate new key
    echo "" | aptos init --network devnet
    
    # Extract account value from config.yaml
    set account_value (grep 'account:' ./.aptos/config.yaml | awk '{print $2}')
    
    # Replace gsvs_addr value in Move.toml
    sed -i "s/gsvs_addr=\"0x[a-f0-9]*\"/gsvs_addr=\"0x$account_value\"/" ./Move.toml
    
    # Extract and copy private key to clipboard
    set private_key (grep 'private_key:' ./.aptos/config.yaml | awk '{print $2}')
    echo -n $private_key | xclip -selection clipboard
    
    echo "✓ Reinitialized Aptos and updated gsvs_addr to: 0x$account_value"
    echo "✓ Private key copied to clipboard"
end
