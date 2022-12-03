{ config, pkgs, ... }:

{
  imports =
    [ ./hardware/fly.nix ./common.nix ./modules/nvidia.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  services.xserver.resolutions = [
    {
      x = 1920;
      y = 1080;
    }
  ];

  networking.networkmanager.enable = true;

  age.secrets.wg-aeza-fly.file = ./secrets/wg/aeza/fly.age;
  networking.wireguard.interfaces = {
    vpn0 = {
      ips = [ "10.66.66.3/32" ];
      privateKeyFile = config.age.secrets.wg-aeza-fly.path;
      peers = [
        {
          publicKey = "t/2RMwSMBXhBfJT8NoOmdn+RG5FWh5rUSGGcHLyt9BQ=";
          allowedIPs = [ "10.66.66.0/24" ];
          endpoint = "78.153.130.61:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  age.secrets.sync-fly-cert.file = ./secrets/syncthing/fly-cert.age;
  age.secrets.sync-fly-key.file = ./secrets/syncthing/fly-key.age;
  age.secrets.sync-fly-cert.owner = "cofob";
  age.secrets.sync-fly-key.owner = "cofob";
  services.syncthing = {
    cert = config.age.secrets.sync-fly-cert.path;
    key = config.age.secrets.sync-fly-key.path;
  };

  networking = {
    hostName = "fly";

    nebula-global = {
      enable = true;
      isLighthouse = false;
    };
  };
}
