{ pkgs, lib, nixpkgs-unstable, self, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable {
        system = pkgs.system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "vscode"
            "vscode-extension-MS-python-vscode-pylance"
            "codeium"
          ];
      };
    })

    self.overlays.default
  ];
}
