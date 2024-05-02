{ pkgs, ... }:

{
  imports = [ ./apps.nix ./dev.nix ./sway.nix ];

  home.packages = with pkgs; [ telegram-desktop spotify vesktop ];
}
