{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
      "vscode-extension-MS-python-vscode-pylance"
      "spotify"
      "megasync"
    ];
}
