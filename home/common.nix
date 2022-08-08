{ config, pkgs, ... }:

{
  imports = [ ./sh.nix ];

  programs.home-manager.enable = true;
  home = {
    homeDirectory = "/home/cofob";
    stateVersion = "22.05";
    username = "cofob";
  };

  services.gpg-agent = {
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    enable = true;
  };

  home.packages = with pkgs; [
    gnupg
  ];
}
