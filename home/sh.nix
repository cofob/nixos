{ config, pkgs, lib, ... }:

{
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    if [[ "$(tty)" != /dev/tty* && $(ps --no-header --pid=$PPID --format=comm) != "zsh" && -z $BASH_EXECUTION_STRING ]]; then
      exec zsh
    fi
  '';

  programs.bat.enable = true;

  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [{
      # My key
      source = ./configs/gpg/cofob.txt;
      trust = 5;
    }];
  };

  programs.zoxide = {
    enableZshIntegration = true;
    enable = true;
  };

  programs.fzf = {
    enableZshIntegration = true;
    enable = true;
  };

  programs.eza = { enable = true; };

  programs.direnv = {
    enableZshIntegration = true;
    enable = true;

    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons";
      la = "${pkgs.eza}/bin/eza --icons -la";
      lt = "${pkgs.eza}/bin/eza --icons --tree";

      nixupd = ''
        sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos"'';
      tnixupd = "sudo nixos-rebuild switch --flake . --fast";
      tnix = "nixos-rebuild dry-build --flake .";
      nixclear = "sudo nix-store --gc && sudo nix-collect-garbage -d && nixupd";
      find_port = "sudo netstat -tulnp | grep";
      find_proc = "sudo ps -aux | grep";
      shell = "nix-shell --run 'zsh' -p";
      brightness = "xrandr --output eDP-1 --brightness";

      please = "sudo";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "zsh-interactive-cd"
        "git-auto-fetch"
        "docker-compose"
        "docker"
        "git"
        "z"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./configs/p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
