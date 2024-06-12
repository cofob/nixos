{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
      "megasync"
      "zerotierone"
      "vscode"
      "vscode-extension-MS-python-vscode-pylance"
    ];
}
