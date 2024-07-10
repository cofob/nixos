{ pkgs, lib, ... }:

{
  # Enable MegaSync at startup
  xdg.configFile = lib.mkIf (pkgs.system == "x86_64-linux") {
    "autostart/megasync.desktop".source =
      "${pkgs.megasync}/share/applications/megasync.desktop";
  };
}
