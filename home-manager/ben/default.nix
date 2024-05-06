{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    outputs.homeManagerModules.eww
    outputs.homeManagerModules.kitty
    outputs.homeManagerModules.common
    outputs.homeManagerModules.desktop
    outputs.homeManagerModules.terminal
    outputs.homeManagerModules.hyprland
  ];

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    packages = with pkgs; [
      vlc
      brave
      discord
      neovide
      mission-center
    ];
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
