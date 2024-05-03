{ lib, pkgs, ... }: {
  wayland.windowManager.sway.enable = true;
  xdg.configFile."sway/config".source = lib.mkForce ./configs/sway.txt;

  programs.waybar.enable = true;
  xdg.configFile."waybar/config".source = lib.mkForce ./configs/waybar.jsonh;

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fuzzel.enable = true;

  # Add audio and brightness utils
  home.packages = with pkgs; [ pulseaudio light ];
}
