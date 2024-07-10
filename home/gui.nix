{ pkgs, lib, config, ... }:

{
  imports = [ ./apps.nix ./sway.nix ./autostart.nix ./gpg.nix ];

  fonts.fontconfig.enable = true;

  services.gnome-keyring.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs;
    [
      # CLI
      feh
      # GUI
      pavucontrol
      deluge
      xfce.thunar
      obs-studio
      telegram-desktop
      vesktop
      wdisplays
      yubikey-waybar
    ] ++ (if pkgs.system == "x86_64-linux" then [
      spotify
      megasync
    ] else
      [ spotify-qt ]);
}
