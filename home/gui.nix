{ pkgs, ... }:

{
  imports = [ ./apps.nix ./dev.nix ./sway.nix ];

  fonts.fontconfig.enable = true;

  services.gnome-keyring.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    manix
    comma
    nix-index
    deluge
    xfce.thunar
    obs-studio
    telegram-desktop
    spotify
    vesktop
    megasync
  ];
}
