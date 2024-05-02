pkgs: inputs:
(import ./packages/top-level.nix { callPackage = pkgs.callPackage; })
