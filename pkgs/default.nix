{ pkgs, ... }:
{
  sddm-astronaut-theme = pkgs.libsForQt5.callPackage ./sddm-astronaut-theme.nix { };
}
