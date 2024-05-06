{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    inputs.hardware.nixosModules.asus-zephyrus-ga402

    outputs.nixosModules.common
  ];

  boot = {
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 5;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libnotify
    vimix-cursors
    sddm-astronaut-theme
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "astronaut";
      settings.Theme.CursorTheme = "dist-white";
    };
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    hyprland.enable = true;
    nm-applet.enable = true;
  };

  users.users.ben = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "bender";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [ "CascadiaCode" ];
    })
  ];

  # Fix Swaylock no password
  security.pam.services.swaylock = { };

  virtualisation.docker.enable = true;

  networking.hostName = "zeph";

  system.stateVersion = "23.11";
}
