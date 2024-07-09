{ callPackage }:

{
  yubikey-waybar = callPackage ./yubikey-waybar { };
  py3env = callPackage ./py3env.nix { };

  ms-python.python = callPackage ./ms-python-vsc.nix { };
}
