{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-x13s.url = "git+https://codeberg.org/adamcstephens/nixos-x13s";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, agenix, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      meta = builtins.mapAttrs
        (key: value: pkgs.lib.importJSON ./machines/${key}/meta.json)
        (builtins.readDir ./machines);
    in {
      nixosModules.home-headless = import ./home/headless.nix;
      nixosModules.home-nixless = import ./home/nixless.nix;

      nixosConfigurations = builtins.mapAttrs (key: value:
        (nixpkgs.lib.nixosSystem {
          system = meta.${key}.system;
          specialArgs = attrs;
          modules = [ ./modules/modules.nix ./machines/${key} ];
        })) (builtins.readDir ./machines);

      overlays.default = final: prev: (import ./overlay.nix final attrs);
    } // flake-utils.lib.eachSystem
    (with flake-utils.lib.system; [ x86_64-linux i686-linux aarch64-linux ])
    (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs =
            [ agenix.packages.${system}.default pkgs.nixfmt-classic ];
        };

        packages = import ./overlay.nix pkgs attrs;
      });
}
