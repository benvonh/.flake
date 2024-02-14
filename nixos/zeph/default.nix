{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    inputs.hardware.nixosModules.asus-zephyrus-ga402

    outputs.nixosModules.common
    outputs.nixosModules.desktop
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "zeph";

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

  virtualisation.docker.enable = false;

  system.stateVersion = "23.11";
}
