{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = github:nix-community/NUR;

    pkgs-overlay = {
      url = "github:cofob/nixos-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nur, pkgs-overlay, agenix, home-manager }:
    {
      nixosModules = {
        home-headless = import ./home/common.nix;
      };
      nixosConfigurations = {
        bear = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./bear.nix
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            agenix.nixosModule
            {
              environment.systemPackages = [ agenix.defaultPackage.x86_64-linux ];
            }
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cofob = import ./home/bear.nix;
            }
            ({ config, pkgs, ... }:
              let
                overlay-custom = final: prev: {
                  custom = import ./pkgs/top-level.nix { inherit pkgs; };
                };
              in
              {
                nixpkgs.overlays = [ overlay-custom ];
              }
            )
            {
              nixpkgs.overlays = [ nur.overlay pkgs-overlay.overlays.default ];
            }
          ];
        };

        fly = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./fly.nix
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            agenix.nixosModule
            {
              environment.systemPackages = [ agenix.defaultPackage.x86_64-linux ];
            }
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cofob = import ./home/fly.nix;
            }
            ({ config, pkgs, ... }:
              let
                overlay-custom = final: prev: {
                  custom = import ./pkgs/top-level.nix { inherit pkgs; };
                };
              in
              {
                nixpkgs.overlays = [ overlay-custom ];
              }
            )
            {
              nixpkgs.overlays = [ nur.overlay pkgs-overlay.overlays.default ];
            }
          ];
        };

        husky = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./husky.nix
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            agenix.nixosModule
            {
              environment.systemPackages = [ agenix.defaultPackage.x86_64-linux ];
            }
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cofob = import ./home/husky.nix;
            }
            ({ config, pkgs, ... }:
              let
                overlay-custom = final: prev: {
                  custom = import ./pkgs/top-level.nix { inherit pkgs; };
                };
              in
              {
                nixpkgs.overlays = [ overlay-custom ];
              }
            )
            {
              nixpkgs.overlays = [ nur.overlay pkgs-overlay.overlays.default ];
            }
          ];
        };
      };
    };
}
