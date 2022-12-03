{ args, config, lib, pkgs, ... }:

{
  imports = [ ./modules/modules.nix ./modules/yggdrasil.nix ./modules/gui.nix ./modules/privacy.nix ./modules/bluetooth.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "mem_sleep_default=deep" ]; # Enable hibernation

  services.earlyoom.enable = true;

  age.secrets.remote-builder.file = ./secrets/credentials/remote-builder.age;

  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
    };
    readOnlyStore = true;
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

    buildMachines = [
      {
        sshKey = config.age.secrets.remote-builder.path;
        system = "x86_64-linux";
        sshUser = "builder";
        hostName = "10.3.7.30";
        maxJobs = 3;
        supportedFeatures = [
          "big-parallel"
        ];
      }
    ];

    distributedBuilds = false;
  };

  programs.ssh.knownHosts = {
    "10.3.7.30".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHKoFVvggf2o3DQsvdAKrfbGMVnly6AmzW/Sebt+1fUW";
  };

  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      flake = "github:cofob/nixos";
      dates = "4:45";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  hardware.enableRedistributableFirmware = true;

  nixpkgs.config.allowUnfree = true;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; let
    upgrade-system = pkgs.writeScriptBin "upgrade-system" ''
      sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos.git?ref=master"
    '';
  in
  [
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
    # C/CPP/RUST
    cmake
    clang
    ninja
    gcc
    pkg-config
    mold
    # Python
    python3
    python3Packages.jedi-language-server
    python3Packages.flake8
    python3Packages.isort
    python3Packages.autopep8
    mypy
    poetry
    black
    # Android
    android-tools
    ungoogled-chromium
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  environment.shellAliases = {
    nixupd = ''sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos"'';
    tnixupd = "sudo nixos-rebuild switch --flake . --fast";
    tnix = "nixos-rebuild dry-build --flake .";
    nixclear = "sudo nix-store --gc && sudo nix-collect-garbage -d && nixupd";
    find_port = "sudo netstat -tulnp | grep";
    find_proc = "sudo ps -aux | grep";
    shell = "nix-shell --run 'zsh' -p";
    please = "sudo";
    brightness = "xrandr --output eDP-1 --brightness";
  };

  console = {
    keyMap = "ru";
  };

  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  services.fstrim.enable = true;

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  age.secrets.password-cofob.file = ./secrets/passwords/cofob.age;
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.cofob = {
      description = "Egor Ternovoy";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      uid = 1000;
      passwordFile = config.age.secrets.password-cofob.path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx"
      ];
    };
    users.root.initialPassword = "root";
  };

  time.timeZone = "Asia/Krasnoyarsk";

  networking.domain = "cofob.ru";
}
