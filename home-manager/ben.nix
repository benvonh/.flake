{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./desktop
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
    username = "ben";
    homeDirectory = "/home/ben";
    stateVersion = "23.11";
    packages = with pkgs; [
      vlc
      brave
      steam
      discord
      neovide
      mission-center
    ];
  };

  programs.home-manager.enable = true;
}
