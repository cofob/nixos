{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];
  users.users.cofob.extraGroups = [ "libvirtd" ];
}
