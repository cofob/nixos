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

  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true; # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true; # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  users.users.cofob.extraGroups = [ "tss" ]; # tss group has access to TPM devices

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
