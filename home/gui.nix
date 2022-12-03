{ pkgs, ... }:

{
  imports = [ ./apps.nix ./dev.nix ];

  programs.kitty = {
    enable = true;
    font = {
      name = "DejaVu Sans";
      size = 10;
    };
    settings = {
      background = "#191919";
    };
  };

  home.packages = with pkgs; [
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
    freefont_ttf
    meslo-lgs-nf
    gyre-fonts
    unifont
    custom.deta
    bottles
    obsidian
    obs-studio
    termusic
    mpv
    krita
    # Screenshots
    maim
    xclip
    xdotool
    konsole
    kdenlive
    (pkgs.writeScriptBin "br" "xrandr --output eDP-1 --brightness $1")
  ];
}
