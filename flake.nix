{
  description = "NixOS & Home Manager configurations powered by Nix flakes";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager.url = github:nix-community/home-manager/release-23.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = github:nixos/nixos-hardware;

    hyprland.url = github:hyprwm/hyprland;
    hyprpaper.url = github:hyprwm/hyprpaper;
  };

  outputs = { self, nixpkgs, home-manager, ...  }@inputs:
  let
    inherit (self) outputs;

    systems = [
      "i686-linux"
      "x86_64-linux"
      "aarch64-linux"

      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays { inherit inputs; };
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      zeph = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./nixos/zeph ];
      };
    };

    homeConfigurations = {
      ben = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home-manager/ben ];
      };
    };
  };
}
