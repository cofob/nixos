{ lib, ... }:

{
  services.xserver.videoDrivers = [
    "nvidia"
    "nouveau"
    "amdgpu"
    "radeon"
    "modesetting"
    "fbdev"
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
