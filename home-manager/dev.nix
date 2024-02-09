{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./terminal
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = false;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    # FIXME: dynamic?
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "23.11";
    packages = with pkgs; [
      vlc
      brave
      neovide
      mission-center
    ];
  };

  programs.home-manager.enable = true;
}
