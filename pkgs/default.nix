pkgs:
{
  vimix-cursors = pkgs.callPackage ./vimix-cursors.nix { };
  sddm-astronaut-theme = pkgs.libsForQt5.callPackage ./sddm-astronaut-theme.nix { };
}
