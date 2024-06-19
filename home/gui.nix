{ pkgs, ... }:

{
  imports = [ ./apps.nix ./sway.nix ];

  fonts.fontconfig.enable = true;

  services.gnome-keyring.enable = true;

  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;
  services.gpg-agent.sshKeys = [ "C2BC41ABFFF6232EA1082DAAF223487B7D7C984F" ];

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
