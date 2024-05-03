{ ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  programs.light.enable = true;

  users.users.cofob.extraGroups = ["video"];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
