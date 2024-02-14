{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    outputs.homeManagerModules.common
    outputs.homeManagerModules.desktop
    outputs.homeManagerModules.terminal
  ];

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    packages = with pkgs; [
      vlc
      brave
      steam
      discord
      neovide
      mission-center
    ];
  };

  home.stateVersion = "23.11";
}
