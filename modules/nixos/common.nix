{ inputs, outputs, lib, config, pkgs, ... }:
{
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

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
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

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d --repair";
  };

  i18n.defaultLocale = "en_AU.UTF-8";

  time.timeZone = "Europe/Berlin";
  # time.timeZone = "Australia/Brisbane";

  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.printing.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  # Disabled for PipeWire
  sound.enable = false;

  # Recommended for PipeWire
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
}
