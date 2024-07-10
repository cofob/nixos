{ pkgs, self, nixos-x13s, ... }:

{
  imports = [
    nixos-x13s.nixosModules.default

    "${self}/hardware/twinkpad.nix"

    "${self}/modules/common.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/bluetooth.nix"
    "${self}/modules/dns-server.nix"
    "${self}/modules/gui.nix"
    "${self}/modules/sway.nix"

    ./libvirt.nix
  ];

  nixos-x13s.enable = true;
  nixos-x13s.bluetoothMac = "02:68:b3:29:da:98";
  nixos-x13s.kernel = "mainline";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cofob = import ./home.nix { inherit self; };

  networking.hostName = "twinkpad";

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  users.users.cofob.extraGroups = [ "networkmanager" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
