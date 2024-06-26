{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs.unstable;
    [ gh-copilot cura ] ++ (with pkgs; [ dbeaver-bin ]);

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions;
      [
        bierner.emojisense
        editorconfig.editorconfig
        github.github-vscode-theme
        github.vscode-github-actions
        github.vscode-pull-request-github
        github.copilot
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        ms-python.isort
        tamasfe.even-better-toml
        shardulm94.trailing-spaces
        tyriar.sort-lines
        vadimcn.vscode-lldb
        davidanson.vscode-markdownlint
        yzhang.markdown-all-in-one
        mkhl.direnv
        serayuzgur.crates
        redhat.vscode-yaml
        hashicorp.terraform
        rust-lang.rust-analyzer
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mypy-type-checker";
          publisher = "ms-python";
          version = "2023.6.0";
          sha256 = "sha256-uL/iHtBX5sSnkM5fVlMRWEtspNcirirjp9O5ScW039c=";
        }
        {
          name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
        }
      ];
    userSettings = {
      # Suggest faster
      "editor.quickSuggestions" = { "strings" = true; };

      "diffEditor.ignoreTrimWhitespace" = false;
      "files.autoSave" = "afterDelay";

      # Sticky nested
      "editor.stickyScroll.enabled" = true;

      # Set tab size
      "editor.tabSize" = 2;

      # Enable ligatures
      "editor.fontLigatures" =
        "'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04'";
      "editor.fontFamily" = "'Monaspace Neon', monospace";

      # Git settings
      "git.enableSmartCommit" = true;
      "git.branchPrefix" = "cofob/";
      "git.confirmSync" = false;
      "git.autofetch" = false;
      "git.autoStash" = true;
      "git.branchProtection" = [ "master" "main" ];
      "git.branchRandomName.enable" = true;
      "git.fetchOnPull" = false;
      "git.mergeEditor" = true;

      # Set editor theme
      "workbench.colorTheme" = "GitHub Dark Dimmed";
      # Disable welcome screen
      "workbench.startupEditor" = "none";

      "debug.openDebug" = "openOnDebugBreak";
      "debug.internalConsoleOptions" = "openOnSessionStart";
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;

      # Python
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.linting.flake8Enabled" = false;
      "python.linting.flake8Path" = "${pkgs.python3Packages.flake8}/bin/flake8";
      "python.linting.mypyEnabled" = true;
      "python.linting.mypyPath" = "${pkgs.mypy}/bin/mypy";
      "python.linting.pydocstyleEnabled" = true;
      "python.linting.pydocstylePath" =
        "${pkgs.python3Packages.pydocstyle}/bin/pydocstyle";
      "python.formatting.blackArgs" = [ "-l120" "-tpy311" ];
      "python.languageServer" = "Pylance";
      "python.sortImports.path" = "${pkgs.python3Packages.isort}/bin/isort";
      "python.formatting.provider" = "black";
      "python.formatting.blackPath" = "${pkgs.black}/bin/black";
      "python.formatting.autopep8Path" =
        "${pkgs.python3Packages.autopep8}/bin/autopep8";
      "python.formatting.yapfPath" = "${pkgs.yapf}/bin/yapf";
      "python.testing.pytestEnabled" = true;
      "python.testing.pytestPath" = "${pkgs.python3Packages.pytest}/bin/pytest";
      "python.venvPath" = "~/.cache/pypoetry/virtualenvs";
      "python.poetryPath" = "${pkgs.poetry}/bin/poetry";
      "python.analysis.autoImportCompletions" = true;

      "editor.inlineSuggest.enabled" = true;

      # Other
      "redhat.telemetry.enabled" = false;
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    userName = "cofob";
    userEmail = "cofob@riseup.net";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vim";
      user.signingkey = "04EEF0BA3B857B065A326067341A36929AC4AC29";
      commit.gpgsign = true;
      tag.gpgsign = true;
      push.gpgsign = "if-asked";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere.enabled = true;
      alias.force-push = "push --force-with-lease";
      url = { "git@github.com:" = { insteadOf = [ "gh:" ]; }; };
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
