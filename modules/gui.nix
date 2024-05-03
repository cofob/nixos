{ pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    fira-code-symbols
    noto-fonts-emoji
    noto-fonts-cjk
    liberation_ttf
    proggyfonts
    noto-fonts
    fira-code
    dina-font
  ];
}
