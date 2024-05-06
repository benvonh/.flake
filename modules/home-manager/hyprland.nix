{ pkgs, ... }:
{
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
        rounding = 0;
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
          "windowsIn       , 1, 2, jiggle, popin"
          "windowsMove     , 1, 2, jiggle, slide"
          "workspaces      , 1, 2, jiggle, slide"
          "specialWorkspace, 1, 2, jiggle, slidevert"
          "fadeOut   , 1, 2, close"
          "windowsOut, 1, 2, close, popin"
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
        vrr = 1;
        focus_on_activate = true;
        disable_autoreload = false;
        disable_hyprland_logo = true;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
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
        "rounding 0, floating:0"
        "rounding 16, floating:1"
        "opacity 0.9 override 0.9 override 0.9, class:kitty"
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
}
