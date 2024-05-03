{ agenix, home-manager, ... }:

{
  imports =
    [ agenix.nixosModules.default home-manager.nixosModules.home-manager ./docker.nix ];
}
