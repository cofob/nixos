{ pkgs, ... }:

{
  imports = [ ./apps.nix ./sway.nix ];

  fonts.fontconfig.enable = true;

  services.gnome-keyring.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    # CLI
    feh
    # GUI
    pavucontrol
    deluge
    xfce.thunar
    obs-studio
    telegram-desktop
    spotify
    vesktop
    megasync
  ];
}
