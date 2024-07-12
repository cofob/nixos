{ pkgs, self, ... }:

{
  imports = [
    "${self}/hardware/husky.nix"
    "${self}/modules/common.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/bluetooth.nix"
    "${self}/modules/dns-server.nix"
    "${self}/modules/gui.nix"
    "${self}/modules/sway.nix"
    ./libvirt.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cofob = import ./home.nix { inherit self; };

  networking.hostName = "husky";

  services.openssh.enable = true;

  custom.syncthing.enable = true;

  services.tailscale.enable = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  users.users.cofob.extraGroups = [ "networkmanager" ];

  # Open ssh port
  networking.firewall.interfaces.ztwfuehebm.allowedTCPPorts = [ 22 ];
}
