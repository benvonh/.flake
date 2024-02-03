{ inputs, outputs, lib, config, pkgs, ... }:
let
  impure = dir: "${config.home.homeDirectory}/home-manager/nixos/home-manager/${dir}";
  path = dir: config.lib.file.mkOutOfStoreSymlink (impure dir);
in
{
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    packages = with pkgs; [
      vlc
      brave
      discord
      mission-center
      gnome.nautilus
      gnome.gnome-calculator
      gnome.gnome-disk-utility
      gnome.gnome-system-monitor

      ranger

      tldr
      todo
      pfetch
      neofetch
      tty-clock
      pipes-rs
      cava

      neovim
      fd
      wget
      curl
      gzip
      unzip
      nodejs
      ripgrep
      tree-sitter

      avizo
      eww-wayland
      mako
      mpvpaper
      rofi-wayland
      swayidle
      swaylock-effects

      libnotify
      pamixer
      sox
      wlr-randr
      wl-clipboard
      xdg-utils
    ];
  };

  programs.home-manager.enable = true;
  programs.htop.enable = true;

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "Coldark-Dark";
    extraPackages = with pkgs.bat-extras; [
      batdiff batman batgrep batwatch
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "benvonh";
    userEmail = "benjaminvonsnarski@gmail.com";
    extraConfig.credential.helper = "store";
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      prompt = "enabled";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      truecolor = true;
      force_tty = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history = {
      share = false;
      ignoreDups = true;
      expireDuplicateFirst = true;
    };
    defaultKeymap = "emacs";
  };

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    settings = {
      shell = "zsh";
      cursor_shape = "block";
      shell_integration = "no-cursor";
      placement_strategy = "center";
    };
    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 11;
    };
    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };

  xdg.configFile = {
    avizo.source = path "avizo";
    eww.source = path "eww";
    hypr.source = path "hypr";
    mako.source = path "mako";
    nvim.source = path "nvim";
    rofi.source = path "rofi";
    swayidle.source = path "swayidle";
    swaylock.source = path "swaylock";
    wofi.source = path "wofi";
  };

  gtk = with pkgs; {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-BL";
      package = gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Numix-Circle";
      package = numix-icon-theme-circle;
    };
    cursorTheme = {
      size = 24;
      name = "dist-white";
      package = vimix-cursors;
    };
    font = {
      size = 11;
      name = "CaskaydiaCove Nerd Font";
      package = (nerdfonts.override { fonts = [ "CaskaydiaCove" ]; });
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
