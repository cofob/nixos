{ self, config, lib, pkgs, ... }:

{
  imports = [ ./unfree-pkgs.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "mem_sleep_default=deep" ]; # Enable hibernation
  boot.readOnlyNixStore = true;

  services.earlyoom.enable = true;

  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    channel.enable = false;
  };

  system.stateVersion = "23.11";

  security.sudo.wheelNeedsPassword = false;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs;
    let
      upgrade-system = pkgs.writeScriptBin "upgrade-system" ''
        sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos.git?ref=master"
      '';
    in [
      upgrade-system
      git
      vim
      htop
      ncdu
      tmux
      terminus_font
      pastebinit
      wget
      ffsend
      unzip
    ];

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  services.fstrim.enable = true;

  # Setup age.
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  age.secrets.password-cofob.file = "${self}/secrets/passwords/cofob.age";
  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    users.cofob = {
      description = "cofob";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      uid = 1000;
      hashedPasswordFile = config.age.secrets.password-cofob.path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx"
      ];
    };
  };

  time.timeZone = lib.mkDefault "Asia/Tbilisi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  networking.domain = "cofob.dev";
}
