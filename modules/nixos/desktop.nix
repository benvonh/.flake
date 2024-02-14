{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [ inputs.grub-theme.nixosModules.default ];

  boot = {
    plymouth = {
      enable = true;
      theme = "hexagon_dots_alt";
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/64x64/apps/nix-snowflake.png";
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
    };
    loader = {
      timeout = 5;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 2;
      };
      grub2-theme = {
        icon = "white";
        theme = "vimix";
        screen = "1080p";
        footer = true;
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "astronaut";
      settings.Theme.CursorTheme = "dist-white";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [ "CascadiaCode" ];
    })
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    vimix-cursors
    sddm-astronaut-theme
  ];

  programs = {
    hyprland.enable = true;
    nm-applet.enable = true;
  };

  # Fix Swaylock no password
  security.pam.services.swaylock = { };
}
