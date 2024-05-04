{ self, ... }:

{
  imports =
    [ "${self}/home/common.nix" "${self}/home/gui.nix" "${self}/home/dev.nix" "${self}/home/games.nix" ];
}
