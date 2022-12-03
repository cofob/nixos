{ config, lib, pkgs, ... }:

{
  config = {
    services = {
      kubo = {
        enable = true;
        localDiscovery = true;
        enableGC = true;
        autoMount = true;
        emptyRepo = true;
      };
    };
  };
}

