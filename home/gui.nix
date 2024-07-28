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
      rclone
      # GUI
      pavucontrol
      deluge
      xfce.thunar
      obs-studio
      telegram-desktop
      vesktop
      wdisplays
      yubikey-waybar
      gnome.file-roller
      gnome.evince
      libreoffice
    ] ++ (if pkgs.system == "x86_64-linux" then [
      spotify
      megasync
    ] else
      [ spotify-qt ]);

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/magnet" = "deluge.desktop";
    "image/png" = "feh.desktop";
    "image/gif" = "feh.desktop";
    "image/bmp" = "feh.desktop";
    "image/jpeg" = "feh.desktop";
    "image/webp" = "feh.desktop";
    "application/zip" = "file-roller.desktop";
    "application/x-gzip" = "file-roller.desktop";
    "application/x-7z-compressed" = "file-roller.desktop";
    "application/pdf" = "evince.desktop";
    "application/vnd.oasis.opendocument" = "libreoffice-writer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "libreoffice-writer.desktop";
    "application/msword" = "libreoffice-writer.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheet" =
      "libreoffice-calc.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      "libreoffice-impress.desktop";
  };
}
