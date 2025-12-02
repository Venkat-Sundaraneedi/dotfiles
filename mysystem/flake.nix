{
  description = "My NixOS flake";

  # ============================================================================
  # INPUTS
  # ============================================================================

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    opencode = {
      url = "github:sst/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ============================================================================
  # OUTPUTS
  # ============================================================================

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      # specialArgs.inputs = inputs;
      modules = [
        # Core configuration
        ./nixos/configuration.nix

        # Hardware & drivers
        ./nixos/modules/nvidia.nix

        # Services
        ./nixos/modules/docker.nix
      ];
    };
  };
}
