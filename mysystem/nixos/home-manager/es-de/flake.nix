{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Use unstable for latest packages; change to nixos-24.11 if preferred
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux"; # Matches your x86_64 setup
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = import ./ES.nix {inherit pkgs;}; # Calls your derivation
  };
}
