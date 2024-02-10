# .flake

My Nix flake for NixOS and Home Manager.

## Online Install

1. Install `nix` from the official [website](https://nixos.org/download.html).

## NixOS Install

1. Install NixOS following the official manual.

2. Clone this repository and enter the custom Nix shell.

```sh
git clone https://github.com/benvonh/.flake ~/.flake

cd ~/.flake

nix-shell
```

3. Create a custom NixOS configuration by adding one in `flake.nix` and creating a new host folder.

```sh
vim flake.nix
# nixosConfigurations = {
#   ...
#   HOSTNAME = nixpkgs.lib.nixosSystem {
#     specialArgs = { inherit inputs outputs; };
#     modules = [ ./nixos/HOSTNAME ];
#   };
# };

cp -r nixos/zeph                         nixos/HOSTNAME
cp /etc/nixos/hardware-configuration.nix nixos/HOSTNAME/hardware.nix

vim nixos/HOSTNAME/default.nix
# EDIT
```

4. Run the Nix flake configuration.

```sh
sudo nixos-rebuild switch --flake ~/.flake
```

## Home Manager Install

1. Install Nix if not using NixOS.

```sh
# Single-user installation
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

2. Clone this repository and enter the custom Nix shell.

```sh
git clone https://github.com/benvonh/.flake ~/.flake

cd ~/.flake

nix-shell
```

3. Create a custom Home Manager configuration by adding one in `flake.nix` and creating a new user folder.

```sh
vim flake.nix
# homeConfigurations = {
#   ...
#   USERNAME = home-manager.lib.homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages.x86_64-linux;
#     extraSpecialArgs = { inherit inputs outputs; };
#     modules = [ ./home-manager/USERNAME ];
#   };
# };

cp -r home-manager/ben home-manager/USERNAME

vim home-manager/USERNAME/default.nix
# EDIT
```

4. Run the Nix flake configuration.

```sh
home-manager switch --flake ~/.flake
```

---

Shout out to [Misterio77](https://github.com/misterio77) for his [nix-starter-configs](https://github.com/misterio77/nix-starter-configs).
