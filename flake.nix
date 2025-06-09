# nix-config/flake.nix
{
  description = "Simple flake-based NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        Marvin = nixpkgs.lib.nixosSystem {
	  inherit system;
          modules = [
            ./configuration.nix
	    {
	      nixpkgs.config.allowUnfree = true;
	    }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tdmunnik = import ./home.nix;
            }

            hyprland.nixosModules.default
          ];
        };
      };
    };
}
