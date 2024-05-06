{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.nautilus
    gnome.gnome-calculator
    gnome.gnome-disk-utility
    gnome.gnome-system-monitor

    # TODO
    jq
    pamixer
  ];

  xdg = {
    dataFile = {
      audio.source = ./audio;
      wallpaper.source = ./wallpapers;
    };
    configFile = {
      eww.source = ./eww;
      hyprpaper = {
        executable = false;
        target = "hypr/hyprpaper.conf";
        text = ''
          preload = ${config.xdg.dataFile.wallpaper.target}/maplestory.png
          wallpaper = , ${config.xdg.dataFile.wallpaper.target}/maplestory.png
          ipc = off
        '';
      };
    };
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
      size = 10;
      name = "CaskaydiaCove Nerd Font";
      package = (nerdfonts.override {
        fonts = [ "CascadiaCode" ];
      });
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {

    kitty = {
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

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      yoffset = 80;
      location = "top";
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "gruvbox-dark";
      font = "CaskaydiaCove Nerd Font 12";
      extraConfig = {
        modes = "drun";
        icon-theme = "Numix-Circle";
        show-icons = true;
      };
    };

    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        ignore-empty-password = true;
        show-failed-attempts = true;
        daemonize = true;
        fade-in = 1;
        grace = 1;

        clock = true;
        timestr = "  ";
        datestr = "%H:%m";
        screenshots = true;

        font = "CaskaydiaCove Nerd Font";
        font-size = 22;

        line-uses-ring = true;

        indicator = true;
        indicator-idle-visible = true;
        indicator-radius = 128;
        indicator-thickness = 4;

        bs-hl-color = "b16286";
        key-hl-color = "8ec07c";
        separator-color = "3c3836";

        inside-color = "282828";
        inside-ver-color = "282828";
        inside-wrong-color = "282828";
        inside-clear-color = "282828";

        ring-color = "3c3836";
        ring-ver-color = "98971a";
        ring-wrong-color = "cc241d";
        ring-clear-color = "a89984";

        text-color = "fbf1c7";
        text-ver-color = "fbf1c7";
        text-wrong-color = "fbf1c7";
        text-clear-color = "fbf1c7";

        effect-blur = "7x7";
        effect-vignette = "0.5:0.5";
      };
    };
  };

  services = {
    mako = {
      enable = true;
      width = 300;
      height = 100;
      anchor = "top-center";
      backgroundColor = "#282828";
      borderColor = "#d65d0e";
      borderRadius = 16;
      borderSize = 2;
      defaultTimeout = 3000;
      font = "CaskaydiaCove Nerd Font 12";
      iconPath = "${pkgs.numix-icon-theme-circle}/share/icons/Numix-Circle";
      layer = "overlay";
      maxVisible = 4;
      margin = "8";
      padding = "8";
      progressColor = "#fe8019";
      textColor = "#fbf1c7";
      extraConfig = ''
        on-notify=exec ${pkgs.sox}/bin/play -q ~/${config.xdg.dataFile.audio.target}/notification.mp3;

        [urgency=critical]
        border-color=#cc241d
      '';
    };

    avizo = {
      enable = true;
      settings = {
        default = {
          time = 1.0;
          fade-in = 1.0;
          fade-out = 1.0;
          block-count = 10;
          block-height = 10;
          block-spacing = 0;
          border-width = 0;
          border-radius = 16;
          background = "rgba(124,111,100,0.8)";
        };
      };
    };

    swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
      ];
      timeouts = [
        {
          timeout = 500;
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
        {
          timeout = 600;
          command = "hyprctl dispatch dpms off";
          resumeCommand = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  systemd.user.startServices = "sd-switch";
}
