{
  description = "Home Manager configuration of greed";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    es-de.url = "path:./es-de";
  };

  outputs = {
    nixpkgs,
    home-manager,
    es-de,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.greed = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit es-de;};

      modules = [./home.nix];
    };
  };
}
