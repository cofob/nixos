{ pkgs, ... }:

{
  imports = [ ./apps.nix ./sway.nix ./autostart.nix ./gpg.nix ];

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
    wdisplays
    yubikey-waybar
  ];
}
