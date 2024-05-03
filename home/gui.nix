{ pkgs, ... }:

{
  imports = [ ./apps.nix ./dev.nix ./sway.nix ];

  fonts.fontconfig.enable = true;

  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    xfce.thunar
    telegram-desktop
    spotify
    vesktop
    megasync
  ];
}
