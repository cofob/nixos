{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, agenix, ... }@attrs:
    {
      nixosModules.home-headless = import ./home/headless.nix;

      nixosConfigurations = builtins.mapAttrs (key: value:
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [ ./modules/modules.nix ./machines/${key} ];
        })) (builtins.readDir ./machines);

      overlays.default = final: prev: (import ./overlay.nix final attrs);
    } // flake-utils.lib.eachSystem
    (with flake-utils.lib.system; [ x86_64-linux i686-linux aarch64-linux ])
    (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ agenix.packages.${system}.default pkgs.nixfmt ];
        };

        packages = {
          system-cache = pkgs.stdenv.mkDerivation {
            pname = "system-cache";
            version = "0.1.0";
            buildInputs = builtins.map (s: s.config.system.build.toplevel) (builtins.attrValues self.nixosConfigurations);
            phases = [ "installPhase" ];
            installPhase = "echo 'system-cache' > $out";
          };
        } // (import ./overlay.nix pkgs attrs);
      });
}
