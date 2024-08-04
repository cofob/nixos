{ callPackage }:

{
  yubikey-waybar = callPackage ./yubikey-waybar { };
  py3env = callPackage ./py3env.nix { };
  download-nixpkgs-cache-index =
    callPackage ./download-nixpkgs-cache-index.nix { };
}
