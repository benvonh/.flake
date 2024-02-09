{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    inputs.hardware.nixosModules.asus-zephyrus-ga402
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = false;
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
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
  };

  networking.hostName = "zeph";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.printing.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "astronaut";
      settings.Theme.CursorTheme = "dist-white";
    };
  };

  time.timeZone = "Europe/Berlin";
  # time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_AU.UTF-8";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.timeout = 60;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 3;
  };

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk rocmPackages.clr.icd
  ];

  environment.variables.AMD_VULKAN_ICD = "RADV";

  users.users = {
    ben = {
      isNormalUser = true;
      initialPassword = "bender";
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
      ];
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

  programs.hyprland.enable = true;

  sound.enable = false;

  security.rtkit.enable = false;
  security.pam.services.swaylock = {};

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}
