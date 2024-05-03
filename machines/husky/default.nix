{ config, pkgs, self, ... }:

{
  imports = [
    "${self}/hardware/husky.nix"
    "${self}/modules/modules.nix"
    "${self}/modules/common.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/gui.nix"
    "${self}/modules/sway.nix"
    ./libvirt.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cofob = import "${self}/home/husky.nix";

  networking.hostName = "husky";

  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  users.users.cofob.extraGroups = [ "networkmanager" ];
}
