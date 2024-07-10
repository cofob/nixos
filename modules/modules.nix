{ agenix, home-manager, ... }:

{
  imports = [
    agenix.nixosModules.default
    home-manager.nixosModules.home-manager
    ./overlays.nix
    ./docker.nix
    ./unfree-pkgs.nix
    ./ssh.nix
    ./syncthing.nix
  ];
}
