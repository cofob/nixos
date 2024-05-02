{ config, lib, pkgs, ... }:

{
  config = {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "zerotierone" ];

    services.zerotierone = { enable = true; };
  };
}
