{ config, pkgs, ... }:

{
  imports =
    [ ./hardware/husky.nix ./common.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  services.xserver = {
    libinput.enable = true;
    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };

  age.secrets.sync-husky-cert.file = ./secrets/syncthing/husky-cert.age;
  age.secrets.sync-husky-key.file = ./secrets/syncthing/husky-key.age;
  age.secrets.sync-husky-cert.owner = "cofob";
  age.secrets.sync-husky-key.owner = "cofob";
  services.syncthing = {
    cert = config.age.secrets.sync-husky-cert.path;
    key = config.age.secrets.sync-husky-key.path;
  };

  networking.networkmanager.enable = true;

  networking = {
    hostName = "husky";
  };
}
