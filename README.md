# .flake

My NixOS and Home Manager configuration flake.

## Dependency

If not using NixOS, install `nix` [here](https://nixos.org/download.html).

## Direct Install (Home Manager only)

:warning: **To remove the Home Manager configuration, you will have to delete all symlinks manually.**

1. Enter the custom shell of this repository.

```sh
nix develop --extra-experimental-features 'nix-command flakes' github:benvonh/.flake
```

2. Switch to a Home Manager configuration.

:stop_sign: *This will fail if existing configs block Home Manager. Back up each of them as seen in the output.*

```sh
# Replace `ben` with an exiting user config.
home-manager switch --flake github:benvonh/.flake#ben
```

## Local Install (Home Manager + NixOS)

1. Clone this repository and enter the custom shell.

:exclamation: *Aliases exist with `~/.flake`. Change these aliases if using a different path.*

```sh
# `nix-shell -p git` if needed

git clone https://github.com/benvonh/.flake ~/.flake

cd ~/.flake

nix-shell
```

2. Create a custom configuration for both NixOS and Home Manager.

```sh
# `nix-shell -p vim` if needed
```

**NixOS:**

```sh
vim flake.nix
# ...
# nixosConfigurations = {
#   ...
#   <your-hostname> = nixpkgs.lib.nixosSystem {
#     specialArgs = { inherit inputs outputs; };
#     modules = [ ./nixos/<your-hostname> ];
#   };
# };

cp -r nixos/zeph nixos/$HOST
cp /etc/nixos/hardware-configuration.nix nixos/$HOST/hardware.nix

vim nixos/$HOST/default.nix
# EDIT

# Also see `modules/nixos`
```

**Home Manager:**

```sh
vim flake.nix
# ...
# homeConfigurations = {
#   ...
#   <your-username> = home-manager.lib.homeManagerConfiguration {
#     pkgs = nixpkgs.legacyPackages.x86_64-linux;
#     extraSpecialArgs = { inherit inputs outputs; };
#     modules = [ ./home/<your-username> ];
#   };
# };

cp -r home/ben home/$USER

vim home/$USER/default.nix
# EDIT

# Also see `modules/home`
```

3. Switch to the NixOS and Home Manager configuration.

```sh
# Add `#<user or host>` to specify which config.
sudo nixos-rebuild switch --flake ~/.flake
home-manager switch --flake ~/.flake

# You can also use my aliases to switch configurations.
nrs
hms
```

## Issues

From experience, `grub` had many problems installing onto my system while replacing `systemd`.
You can use the following to help debug your problem.

```sh
# Add ` -- <arguments>` to pass arguments.
nix run nixpkgs#efibootmgr
```

## Thanks to...

- [Misterio77](https://github.com/misterio77) for his [nix-starter-configs](https://github.com/misterio77/nix-starter-configs) template
- [Vimjoyer](https://www.youtube.com/@vimjoyer) for his awesome YouTube content on Nix
