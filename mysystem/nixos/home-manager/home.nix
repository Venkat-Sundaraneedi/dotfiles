{
  config,
  pkgs,
  ...
}: {
  home.username = "greed";
  home.homeDirectory = "/home/greed";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

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
    somo # port monitor
    rustscan

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
    # mpd
    rmpc
    spotdl

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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.file = {
  };

  programs = {
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/greed/Music/";
      playlistDirectory = "/home/greed/Music/Playlists/";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
