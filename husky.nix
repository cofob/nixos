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

  networking.networkmanager.enable = true;

  networking = {
    hostName = "husky";
  };
}
