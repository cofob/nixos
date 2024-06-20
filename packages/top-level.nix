{ callPackage }:

{
  yubikey-waybar = callPackage ./yubikey-waybar { };
  py3env = callPackage ./py3env.nix { };
}
