{ lib, config, pkgs, ... }:

{
  options.virtualisation.docker.enableWatchtower = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Enable automatic image updates.
    '';
  };

  config = lib.mkMerge [
    (lib.mkIf config.virtualisation.docker.enable {
      # auto cleanup
      virtualisation.docker.autoPrune.enable = true;
      virtualisation.docker.autoPrune.dates = "weekly";
      virtualisation.docker.autoPrune.flags = [ "--all" ];

      # IPv6 support
      virtualisation.docker.daemon.settings = {
        fixed-cidr-v6 = "fd00::/80";
        ipv6 = true;
        experimental = true;
      };

      # enable containers on boot
      virtualisation.docker.enableOnBoot = true;

      # access docker from normal user
      users.users.cofob.extraGroups = [ "docker" ];
    })
    (lib.mkIf config.virtualisation.docker.enableWatchtower {
      virtualisation.oci-containers = {
        backend = "docker";
        containers.watchtower = {
          image = "containrrr/watchtower";
          volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
        };
      };
    })
  ];
}
