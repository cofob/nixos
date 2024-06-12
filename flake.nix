{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-x13s.url = "git+https://codeberg.org/adamcstephens/nixos-x13s";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, agenix, ... }@attrs:
    let
      meta = builtins.mapAttrs
        (key: value: nixpkgs.lib.importJSON ./machines/${key}/meta.json)
        (builtins.readDir ./machines);
    in {
      nixosModules.home-headless = import ./home/headless.nix;

      nixosConfigurations = (builtins.mapAttrs (key: value:
        (nixpkgs.lib.nixosSystem {
          system = meta.${key}.system;
          specialArgs = attrs;
          modules = [ ./modules/modules.nix ./machines/${key} ];
        })) (builtins.readDir ./machines)) // {
          iso = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              attrs.nixos-x13s.nixosModules.default
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
              ({ pkgs, ... }: { environment.systemPackages = [ pkgs.vim ]; })
              ({ ... }: {
                nixos-x13s.enable = true;
                nixos-x13s.kernel = "jhovold";
                nixos-x13s.bluetoothMac = "1A:2B:3C:4D:5E:6F";

                # allow unfree firmware
                nixpkgs.config.allowUnfree = true;
              })
            ];
          };

        };

      overlays.default = final: prev: (import ./overlay.nix final attrs);
    } // flake-utils.lib.eachSystem
    (with flake-utils.lib.system; [ x86_64-linux i686-linux aarch64-linux ])
    (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ agenix.packages.${system}.default pkgs.nixfmt ];
        };

        packages = import ./overlay.nix pkgs attrs;
      });
}
