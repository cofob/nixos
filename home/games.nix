{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    unstable.superTuxKart
    unstable.xonotic
    polymc
  ];
}
