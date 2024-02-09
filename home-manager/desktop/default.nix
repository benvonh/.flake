{ inputs, outputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs.gnome; [
    nautilus
    gnome-calculator
    gnome-disk-utility
    gnome-system-monitor
  ];

  programs.rofi = {
    enable = true;
    cycle = true;
    font = "CaskaydiaCove Nerd Font 14";
    location = "top";
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "gruvbox-dark";
  };

  programs.eww = {
    enable = true;
    configDir = ./eww;
  };

  services.avizo = {
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

  services.mako = {
    enable = true;
    width = 300;
    height = 100;
    anchor = "top-center";
    backgroundColor = "#282828";
    borderColor = "#d65d0e";
    borderRadius = 16;
    borderSize = 1;
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
      on-notify=exec ${pkgs.sox}/bin/play -q ${config.xdg.dataHome}/notification.mp3;

      [urgency=critical]
      border-color=#cc241d
    '';
  };

  services.swayidle = {
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

  programs.swaylock = {
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
      font-size = 24;

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

  xdg.configFile = {
    hyprpaper = {
      executable = false;
      target = "hypr/hyprpaper.conf";
      text = ''
        preload = ${config.xdg.dataHome}/astronaut.jpg
        wallpaper = , ${config.xdg.dataHome}/astronaut.jpg
        ipc = off
      '';
    };
  };

  xdg.dataFile = {
    "astronaut.jpg".source = ./assets/astronaut.jpg;
    "notification.mp3".source = ./assets/notification.mp3;
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "GTK_THEME, Gruvbox-Dark-BL"
        "XCURSOR_THEME, dist-white"
        "XCURSOR_SIZE, 24"
      ];
      exec-once = [
        "hyprctl setcursor dist-white 24"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.eww-wayland}/bin/eww daemon && ${pkgs.eww-wayland}/bin/eww open bar"
      ];
      monitor = "eDP-2, 1920x1200@144, 0x0, 1";
      layerrule = "blur, gtk-layer-shell";
      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;
        "col.inactive_border" = "rgba(928374ff)";
        "col.active_border" = "rgba(d65d0eff)";
        cursor_inactive_timeout = 10;
        layout = "master";
        resize_on_border = true;
      };
      decoration = {
        rounding = 16;
        shadow_range = 16;
        shadow_render_power = 2;
        "col.shadow" = "rgba(000000dd)";
        "col.shadow_inactive" = "rgba(00000066)";
        blur = {
          size = 9;
        };
      };
      animations = {
        bezier = [
          "jiggle, 0.15, 1.15, 0.50, 1.00"
          "close, 0.00, 0.85, 1.00, 0.85"
        ];
        animation = [
          "windowsIn       , 1, 4, jiggle, popin"
          "windowsMove     , 1, 4, jiggle, slide"
          "workspaces      , 1, 4, jiggle, slide"
          "specialWorkspace, 1, 4, jiggle, slidevert"
          "fadeOut   , 1, 4, close"
          "windowsOut, 1, 4, close, popin"
        ];
      };
      input = {
        sensitivity = -0.1;
        numlock_by_default = true;
        accel_profile = "adaptive";
        scroll_method = "2fg";
        touchpad = {
          natural_scroll = true;
        };
      };
      misc = {
        disable_hyprland_logo = true;
        vrr = 1;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_autoreload = false;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = 20;
      };
      master = {
        mfact = 0.5;
        new_on_top = true;
        new_is_master = false;
        no_gaps_when_only = 0;
        special_scale_factor = 0.9;
      };
      windowrulev2 = [
        "float, class:gnome"
        "float, title:[Ff]ile"
        "float, title:[Ff]older"
        "center, class:gnome"
        "center, title:[Ff]ile"
        "center, title:[Ff]older"
        "opacity 0.85 override 0.85 override 0.85, class:kitty"
      ];
      "$MOD" = "SUPER";
      "$ENTER" = 36;
      "$SPACE" = 65;
      bind = [
        "$MOD SHIFT,      Q, exit,"
        "$MOD      , $SPACE, fullscreen,"
        "$MOD      ,      F, togglefloating,"
        "$MOD      ,      C, killactive,"
        "$MOD      ,      L, exec, swaylock"
        "$MOD      ,      E, exec, nautilus"
        "$MOD      ,      B, exec, brave"
        "$MOD      ,      P, exec, rofi -show drun -show-icons"
        "$MOD      , $ENTER, exec, kitty"

        "ALT      ,      J, layoutmsg, cyclenext"
        "ALT      ,      K, layoutmsg, cycleprev"
        "ALT      ,      I, layoutmsg, addmaster"
        "ALT      ,      D, layoutmsg, removemaster"
        "ALT SHIFT,      J, layoutmsg, swapnext"
        "ALT SHIFT,      K, layoutmsg, swapprev"
        "ALT SHIFT,      I, layoutmsg, orientationnext"
        "ALT SHIFT,      D, layoutmsg, orientationprev"
        "ALT SHIFT, $ENTER, layoutmsg, swapwithmaster"

        "ALT      ,   S, togglespecialworkspace,"
        "ALT SHIFT,   S, movetoworkspace, special"
        "ALT      , TAB, workspace            , e+1"
        "ALT      ,   1, workspace            , 1"
        "ALT      ,   2, workspace            , 2"
        "ALT      ,   3, workspace            , 3"
        "ALT      ,   4, workspace            , 4"
        "ALT      ,   5, workspace            , 5"
        "ALT SHIFT,   1, movetoworkspacesilent, 1"
        "ALT SHIFT,   2, movetoworkspacesilent, 2"
        "ALT SHIFT,   3, movetoworkspacesilent, 3"
        "ALT SHIFT,   4, movetoworkspacesilent, 4"
        "ALT SHIFT,   5, movetoworkspacesilent, 5"

        ", XF86AudioRaiseVolume , exec, volumectl -u + 10"
        ", XF86AudioLowerVolume , exec, volumectl -u - 10"
        ", XF86AudioMicMute     , exec, volumectl -m toggle-mute"
        ", XF86AudioMute        , exec, volumectl    toggle-mute"
        ", XF86MonBrightnessUp  , exec, lightctl + 10"
        ", XF86MonBrightnessDown, exec, lightctl - 10"
        ", XF86KbdBrightnessUp  , exec, lightctl -D asus::kbd_backlight + 10"
        ", XF86KbdBrightnessDown, exec, lightctl -D asus::kbd_backlight - 10"
      ];
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
    };
  };

  systemd.user.startServices = "sd-switch";
}
