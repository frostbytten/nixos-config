{
  description = "My NixOS Configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, nixos-hardware, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      user = "frostbytten";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        kurapika = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.system76
            home-manager.nixosModules.home-manager
	    hyprland.nixosModules.default
            ./machines/kurapika.nix
            ./modules/base.nix
            ./modules/desktop.nix
            ./modules/bspwm.nix
            ./modules/audio.nix
            ./modules/games.nix
	    ./modules/dev.nix
          ];
        };
      };
    };
}
