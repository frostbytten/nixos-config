{
  description = "My NixOS Configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, nixos-hardware, home-manager, ... }:
  let
    system = "x86_64-linux";
    user = "frostbytten";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      kurapika = lib.nixosSystem {
        inherit system;
	modules = [
	  ./configuration.nix
	  nixos-hardware.nixosModules.system76
          ./machines/kurapika.nix
          ./modules/packages.nix
          ./modules/xserver.nix
	  ./modules/services.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.frostbytten = {
	      imports = [ ./modules/home-manager.nix ];
	    };
	  }
	];
      };
    };
  };
}
