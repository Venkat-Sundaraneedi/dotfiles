{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  # ┌─────────────────────────────────────┐
  # │            BOOT & KERNEL            │
  # └─────────────────────────────────────┘

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # ┌─────────────────────────────────────┐
  # │             NETWORKING              │
  # └─────────────────────────────────────┘

  networking = {
    wireless.iwd.enable = true;
    hostName = "nixos";
    networkmanager.enable = false;
    firewall.enable = true;
    # firewall.allowedTCPPorts = [ ];
    # firewall.allowedUDPPorts = [ ];
  };

  # ┌─────────────────────────────────────┐
  # │            LOCALIZATION             │
  # └─────────────────────────────────────┘

  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "en_IN";
    defaultCharset = "UTF-8";
    extraLocales = ["en_IN/UTF-8"];
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # ┌──────────────────────────────────────────┐
  # │   DISPLAY SERVER & DESKTOP ENVIRONMENT   │
  # └──────────────────────────────────────────┘

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.displayManager = {
    gdm.enable = true;
  };
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  # ┌─────────────────────────────────────┐
  # │               AUDIO                 │
  # └─────────────────────────────────────┘

  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # ┌─────────────────────────────────────┐
  # │             HARDWARE                │
  # └─────────────────────────────────────┘

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ┌─────────────────────────────────────┐
  # │             SERVICES                │
  # └─────────────────────────────────────┘

  services = {
    # gvfs.enable = true; # Enable GVFS for GNOME
    jackett = {
      enable = true;
      user = "greed";
    };
    flatpak.enable = true;
    fwupd.enable = true;
    openssh.enable = true;

    kmonad = {
      enable = true;
      keyboards.mykmonadoutput = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./kmonad/config.kbd;
      };
    };
  };

  # ┌─────────────────────────────────────┐
  # │               FONTS                 │
  # └─────────────────────────────────────┘

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # ┌─────────────────────────────────────┐
  # │               USERS                 │
  # └─────────────────────────────────────┘

  users.users.greed = {
    isNormalUser = true;
    description = "0xgsvs";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "jackett"
    ];
    shell = pkgs.fish;
  };

  # ┌─────────────────────────────────────┐
  # │          SYSTEM PACKAGES            │
  # └─────────────────────────────────────┘

  environment.systemPackages = with pkgs; [
    home-manager
    git
    curl
    wget
    lshw
    pciutils
    stow
    wl-clipboard
    brave
    ghostty
    neovim
    xwayland-satellite
    # libmtp
    # gvfs
    simple-mtpfs
  ];

  # ┌─────────────────────────────────────┐
  # │             PROGRAMS                │
  # └─────────────────────────────────────┘

  programs = {
    nix-ld = {enable = true;};
    niri = {
      enable = true;
    };

    direnv = {
      enable = true;
      package = pkgs.direnv;
      silent = true;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };

    appimage = {
      enable = true;
      binfmt = true;
    };

    fish = {
      enable = true;
      useBabelfish = true;
      shellAliases = {
        devshell = "nix shell nixpkgs#glib nixpkgs#openssl nixpkgs#gcc nixpkgs#gnumake nixpkgs#pkg-config nixpkgs#stdenv.cc.cc nixpkgs#zlib nixpkgs#openssl.dev";
      };
    };

    mtr.enable = true;
    steam.enable = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
  };

  # ┌─────────────────────────────────────┐
  # │         NIX CONFIGURATION           │
  # └─────────────────────────────────────┘

  nixpkgs.config.allowUnfree = true;

  nix = {
    registry.templates = {
      from = {
        type = "indirect";
        id = "templates";
      };
      to = {
        type = "path";
        path = "/home/greed/git/dotfiles/mysystem/nixos/nixos-templates/";
      };
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # ┌─────────────────────────────────────┐
  # │              SYSTEM                 │
  # └─────────────────────────────────────┘

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "25.11";
}
