{ inputs, outputs, lib, config, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Allow steam
    config.allowUnfree = true;
  };

  nix = {
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = [ "/etc/nix/path" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d --repair";
    };
  };

  environment = {
    etc = lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
    systemPackages = with pkgs; [
      vim git
    ];
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    pipewire.enable = true;
    pipewire.alsa.enable = true;
    pipewire.pulse.enable = true;
  };

  i18n.defaultLocale = "en_AU.UTF-8";

  time.timeZone = "Europe/Berlin";
  # time.timeZone = "Australia/Brisbane";

  networking.networkmanager.enable = true;

  # Recommended for PipeWire
  security.rtkit.enable = true;

  # Disabled for PipeWire
  sound.enable = false;
}
