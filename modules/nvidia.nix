{ ... }:

{
  services.xserver.videoDrivers = [
    "nvidia"
    "nouveau"
    "amdgpu"
    "radeon"
    "modesetting"
    "fbdev"
  ];
}
