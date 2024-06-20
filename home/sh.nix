{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    manix
    comma
    nix-index
    ranger
    python312
    python312Packages.ipython
    py3env
  ];

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

  programs.direnv = {
    enableZshIntegration = true;
    enable = true;

    nix-direnv.enable = true;
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "rainbow";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;

    shellAliases = {
      nixupd = ''
        sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos"'';
      tnixupd = "sudo nixos-rebuild switch --flake . --fast";
      tnix = "nixos-rebuild dry-build --flake .";
      find_port = "sudo netstat -tulnp | grep";
      find_proc = "sudo ps -aux | grep";
      shell = "nix-shell --run 'zsh' -p";
      upload = "/home/cofob/Development/upload-to-s3/upload_to_s3.py";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "zsh-interactive-cd" "docker" "git" "z" ];
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
