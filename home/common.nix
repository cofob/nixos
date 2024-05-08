{ config, pkgs, ... }:

{
  imports = [ ./sh.nix ./overlays.nix ];

  programs.home-manager.enable = true;
  home = {
    homeDirectory = "/home/cofob";
    stateVersion = "23.11";
    username = "cofob";
  };

  services.gpg-agent = {
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    enable = true;
  };
}
