{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  programs.light.enable = true;
  users.users.cofob.extraGroups = [ "video" ];
  # https://wiki.archlinux.org/title/backlight#ACPI
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w $sys$devpath/brightness"
  '';

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
