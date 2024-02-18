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
    publicKeys = [
      {
        # My key
        source = ./configs/gpg/cofob.txt;
        trust = 5;
      }
      {
        # Averyanalex
        source = ./configs/gpg/alex.txt;
        trust = 4;
      }
    ];
  };

  programs.neovim = {
    enable = false;
    coc.enable = true;
    coc.package = pkgs.vimPlugins.coc-nvim;
    coc.settings = {
      "svelte.enable-ts-plugin" = true;

      "eslint.packageManager" = "yarn";
      "eslint.nodePath" = ".yarn/sdks";
      "workspace.workspaceFolderCheckCwd" = false;
      "tsserver.tsdk" = ".yarn/sdks/typescript/lib";

      "tailwindCSS.headwind.runOnSave" = true;
      "tailwindCSS.headwind.removeDuplicates" = true;
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = ''
      set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
      set guifont=Fura\ Code\ Light\ Nerd\ Font\ Complete:h16
      let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
      let g:airline#extensions#xkblayout#enabled = 0
      let g:airline#extensions#keymap#enabled = 0
      let g:airline_powerline_fonts = 1
      let g:Powerline_symbols='unicode'
      let g:auto_save = 1
      filetype plugin indent on
      filetype off
      syntax on
      colorscheme monokai
      set formatoptions=tcqrn1
      set encoding=utf-8
      set softtabstop=2
      set nocompatible
      set shiftwidth=2
      set noshiftround
      set cursorline
      set smartcase
      set tabstop=2
      set expandtab
      set nobackup
      set showmode
      set showcmd
      set ttyfast
      set number
      set wrap
    '';
    plugins = with pkgs.vimPlugins; [
      nerdtree
      vim-auto-save
      vim-fugitive
      vim-devicons
      vim-monokai
      vim-airline
      rust-vim
      vim-nix
      coc-svelte
      vim-svelte
      coc-tailwindcss
      editorconfig-nvim
      coc-tsserver
      coc-tslint-plugin
      coc-rust-analyzer
      vim-flutter
      coc-flutter
    ];
  };

  programs.zoxide = {
    enableZshIntegration = true;
    enable = true;
  };

  programs.fzf = {
    enableZshIntegration = true;
    enable = true;
  };

  programs.eza = {
    enable = true;
  };

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

      nixupd = ''sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/nixos"'';
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
