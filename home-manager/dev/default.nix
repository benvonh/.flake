{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    outputs.homeManagerModules.common
    outputs.homeManagerModules.terminal
  ];

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
