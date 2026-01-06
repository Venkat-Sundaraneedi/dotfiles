{
  config,
  pkgs,
  es-de,
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

    # ES-DE AppImage wrapped as Nix package
    es-de.packages.${pkgs.system}.default

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
    file

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
    rmpc
    mpd
    spotdl

    # Other CLI
    brightnessctl
    gettext
    # ggshield
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

    atac
    xh
    wiremix

    # Terminal & Multiplexers
    fuzzel
    ghostty
    swaybg
    swaylock
    zellij

    w3m
    ddgr
    surfraw
    rtorrent
    acpi

    graphite-cli
    radio-active

    # Containers
    lazydocker
    qbittorrent

    # GUI file manager
    nautilus
    androidenv.androidPkgs.platform-tools

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
    retroarch = {
      enable = true;
      cores = {
        atari800.enable = true;

        beetle-pce.enable = true;
        beetle-pce-fast.enable = true;
        beetle-supergrafx.enable = true;
        beetle-vb.enable = true;
        beetle-gba.enable = true;
        beetle-ngp.enable = true;
        beetle-psx.enable = true;
        beetle-lynx.enable = true;
        beetle-pcfx.enable = true;
        beetle-wswan.enable = true;
        beetle-psx-hw.enable = true;
        beetle-saturn.enable = true;
        beetle-supafaust.enable = true;
        bsnes-mercury-balanced.enable = true;
        bsnes-mercury-performance.enable = true;
        bsnes.enable = true;
        bsnes-hd.enable = true;
        blastem.enable = true;
        bluemsx.enable = true;

        citra.enable = true;

        dosbox.enable = true;
        dosbox-pure.enable = true;
        desmume.enable = true;
        dolphin.enable = true;
        desmume2015.enable = true;

        eightyone.enable = true;
        easyrpg.enable = true;

        fmsx.enable = true;
        fuse.enable = true;
        fbneo.enable = true;
        fceumm.enable = true;
        flycast.enable = true;
        freeintv.enable = true;
        fbalpha2012.enable = true;

        genesis-plus-gx.enable = true;
        gw.enable = true;
        gpsp.enable = true;
        gambatte.enable = true;

        handy.enable = true;
        hatari.enable = true;

        mame2016.enable = true;
        mrboom.enable = true;
        mgba.enable = true;
        mesen.enable = true;
        meteor.enable = true;
        melonds.enable = true;
        mupen64plus.enable = true;

        nxengine.enable = true;
        neocd.enable = true;
        np2kai.enable = true;
        nestopia.enable = true;

        o2em.enable = true;
        opera.enable = true;

        ppsspp.enable = true;
        play.enable = true;
        puae.enable = true;
        pcsx2.enable = true;
        prboom.enable = true;
        picodrive.enable = true;
        prosystem.enable = true;

        quicknes.enable = true;

        snes9x2010.enable = true;
        smsplus-gx.enable = true;
        swanstation.enable = true;
        stella2014.enable = true;
        sameboy.enable = true;

        thepowdertoy.enable = true;
        twenty-fortyeight.enable = true;
        tic80.enable = true;
        tgbdual.enable = true;

        vice-xvic.enable = true;
        vecx.enable = true;
        vba-next.enable = true;

        yabause.enable = true;
      };
      # package = pkgs.retroarch-full;
    };
    neovim = {
      enable = true;
    };
  };

  services = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
