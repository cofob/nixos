{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    "twinkpad-enc" = {
      device = "/dev/disk/by-uuid/0dee99cc-14a5-4d25-9abc-ded8843fbd60";
      preLVM = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d78bc935-5392-4214-8130-d392dbea00e4";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B034-D54E";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/19d930bb-f50b-4941-acb9-21ffdf944f16"; }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
