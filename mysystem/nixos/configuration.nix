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
  services.desktopManager = {
    cosmic.enable = false;
  };
  services.system76-scheduler.enable = false;
  # environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  #   cosmic-term
  # ];
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
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # jack.enable = true;
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
    # printing.enable = true;
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
    ];
    shell = pkgs.fish;
  };

  # ┌─────────────────────────────────────┐
  # │          SYSTEM PACKAGES            │
  # └─────────────────────────────────────┘

  environment.systemPackages = with pkgs; [
    # ┌─────────────────────────────────────┐
    # │         DEVELOPMENT TOOLS           │
    # └─────────────────────────────────────┘

    # Languages & Runtimes
    bun
    lua-language-server
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    nodejs_24

    # Version Control
    difftastic
    gh
    git
    jjui
    jujutsu
    lazygit
    nix-prefetch-github

    # LSPs & Formatters
    alejandra # nix formatter
    nil

    # Other Dev Tools
    mise
    repomix

    # ┌─────────────────────────────────────┐
    # │            CLI TOOLS                │
    # └─────────────────────────────────────┘

    # Modern Alternatives
    bat # cat replacement
    dust # du replacement
    eza # ls replacement
    fd # find replacement
    ripgrep # grep replacement
    zoxide # cd replacement

    # Search & Text Processing
    fzf
    jq
    opencode

    # File Operations
    unzip

    # Network Tools
    curl
    wget

    # Email & Communication
    aerc
    bluetui
    isync
    lynx
    msmtp
    notmuch
    pass

    # Media & Entertainment
    mpd
    rmpc
    spotdl
    spotify

    # Other CLI
    brightnessctl
    gettext
    ggshield
    gpg-tui
    imagemagick
    poppler
    resvg
    tldr
    usage

    # ┌─────────────────────────────────────┐
    # │           SYSTEM TOOLS              │
    # └─────────────────────────────────────┘

    # Monitoring
    btop
    fastfetch

    # Utilities
    lshw
    pciutils
    stow
    wl-clipboard

    # Nix Helpers
    nh
    nix-output-monitor
    nix-search-tv
    nvd
    television

    # ┌─────────────────────────────────────┐
    # │           APPLICATIONS              │
    # └─────────────────────────────────────┘

    # GUI Applications
    brave
    discord
    siyuan

    # Terminal & Multiplexers
    fuzzel
    ghostty
    swaybg
    swaylock
    zellij

    # Containers
    lazydocker

    # Commented Out
    # solana-cli
    # appimage-run
  ];

  # ┌─────────────────────────────────────┐
  # │             PROGRAMS                │
  # └─────────────────────────────────────┘

  programs = {
    nix-ld = {
      enable = true;
      # libraries = with pkgs; [
      #   gcc gnumake pkg-config stdenv.cc.cc
      #   zlib openssl openssl.dev
      # ];
    };

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

    # appimage = {
    #   enable = true;
    #   binfmt = true;
    # };

    fish = {
      enable = true;
      useBabelfish = true;
      shellAliases = {
        devshell = "nix shell nixpkgs#glib nixpkgs#openssl nixpkgs#gcc nixpkgs#gnumake nixpkgs#pkg-config nixpkgs#stdenv.cc.cc nixpkgs#zlib nixpkgs#openssl.dev";
      };
    };

    mtr.enable = true;

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
