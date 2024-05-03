{ pkgs, ... }:

{
  imports = [ ./apps.nix ./dev.nix ./sway.nix ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ telegram-desktop spotify vesktop megasync ];
}
