{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    stdenv = pkgs.stdenv;
    pname = "es-de";
    version = "3.4.0";
    src = pkgs.fetchurl {
      url = "https://gitlab.com/es-de/emulationstation-de/-/package_files/246875981/download";
      hash = "sha256-TLZs/JIwmXEc+g7d2D22R0SmKU4C4//Rnuhn93qI7H4=";
    };
    appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
  in {
    packages.${stdenv.hostPlatform.system}.default = pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/ES-DE.desktop -t $out/share/applications || true
        substituteInPlace $out/share/applications/ES-DE.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}' || true
        cp -r ${appimageContents}/usr/share/icons $out/share || true
      '';
      extraPkgs = pkgs:
        with pkgs; [
          # Test first; add qt6.qtbase, qt6.qtsvg, libglvnd, xorg.libX11 if needed
        ];
      extraBwrapArgs = [
        "--bind-try /home/greed/.config/retro/ROMs /home/greed/.config/retro/ROMs"
      ];
      dieWithParent = false;
      meta = {
        description = "EmulationStation Desktop Edition - A frontend for browsing and launching games from your multi-platform game collection";
        homepage = "https://es-de.org";
        license = pkgs.lib.licenses.mit;
      };
    };
  };
}
