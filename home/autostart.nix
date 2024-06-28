{ pkgs, ... }:

{
  # Enable MegaSync at startup
  xdg.configFile."autostart/megasync.desktop".source = "${pkgs.megasync}/share/applications/megasync.desktop";
}
