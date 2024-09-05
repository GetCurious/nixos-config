{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
    	url = "github:nix-community/home-manager/release-24.05";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  	let
  	  lib = nixpkgs.lib;
  	  system = "x86_64-linux";
  	  pkgs = import nixpkgs { 
        inherit system; 
        config.allowUnfree = true;
      };
  	  pkgs-unstable = import nixpkgs-unstable {
        inherit system; 
        config.allowUnfree = true; 
      };

  	in {
  	  nixosConfigurations = {
  	  	nixos = nixpkgs.lib.nixosSystem {
  	  		inherit system;
          specialArgs = {
            inherit pkgs-unstable;
          };
  	  		modules = [ ./configuration.nix ];
  	  	};
  	  };
  	  
      homeConfigurations = {
  	  	"naton@nixos" = home-manager.lib.homeManagerConfiguration {
  	  	  inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs-unstable;
          };
  	  	  modules = [ ./home.nix ];
	      };
      };

  };
}
