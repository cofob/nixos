{ pkgs, ... }:

{
  imports = [ ./sound.nix ];

  programs.yubikey-touch-detector.enable = true;

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    monaspace
    meslo-lgs-nf
  ];
}
