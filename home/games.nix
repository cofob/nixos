{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ superTuxKart xonotic prismlauncher ];
}
