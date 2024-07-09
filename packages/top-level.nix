{ callPackage }:

{
  yubikey-waybar = callPackage ./yubikey-waybar { };
  py3env = callPackage ./py3env.nix { };

  vscode-extensions.ms-python.python = callPackage ./ms-python-vsc.nix { };
}
