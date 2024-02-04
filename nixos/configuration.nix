{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    inputs.hardware.nixosModules.asus-zephyrus-ga402
    inputs.hyprland.nixosModules.default
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;}))
                 ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  networking.hostName = "zeph";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.printing.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.pulse.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "astronaut";
      settings.Theme.CursorTheme = "dist-white";
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  i18n.defaultLocale = "en_AU.UTF-8";

  time.timeZone = "Europe/Berlin";
  #time.timeZone = "Europe/Australia";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
  };

  users.users = {
    ben = {
      initialPassword = "bender";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
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
    vim
    git
    vimix-cursors
    sddm-astronaut-theme
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  sound.enable = true;
  programs.hyprland.enable = true;
  hardware.pulseaudio.enable = false;

  system.stateVersion = "23.11";
}
