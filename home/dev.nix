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
        rust-lang.rust-analyzer
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mypy-type-checker";
          publisher = "ms-python";
          version = "2023.6.0";
          sha256 = "sha256-uL/iHtBX5sSnkM5fVlMRWEtspNcirirjp9O5ScW039c=";
        }
        {
          name = "flake8";
          publisher = "ms-python";
          version = "2023.10.0";
          sha256 = "sha256-4Vjw8yJPrxLg0hcoTw8AEBEcmQ9sEUNqFaHLxICks0E=";
        }
        {
          name = "copilot-chat";
          publisher = "GitHub";
          version = "0.17.0";
          sha256 = "sha256-zIn81+A42dYkfsHdC3ZLlXxbRBFTEWno6TgrLncIazM=";
        }
        {
          name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
        }
        {
          name = "amber-language";
          publisher = "Ph0enixKM";
          version = "1.2.6";
          sha256 = "sha256-Uxw6v8tc12haqgBFaTogEHEkzCYg+mzoIhCCZ6cyeX0=";
        }
      ];
    userSettings = {
      # Suggest faster
      "editor.quickSuggestions" = { "strings" = true; };

      "diffEditor.ignoreTrimWhitespace" = false;
      "files.autoSave" = "afterDelay";

      # Sticky nested
      "editor.stickyScroll.enabled" = true;

      # Auto rename html tags
      "editor.linkedEditing" = true;

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
      "python.languageServer" = "Pylance";
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "mypy-type-checker.path" = [ "${pkgs.mypy}/bin/mypy" ];
      "mypy-type-checker.preferDaemon" = true;
      "isort.path" = [ "${pkgs.python3Packages.isort}/bin/isort" ];
      "black-formatter.path" = [ "${pkgs.black}/bin/black" ];
      "black-formatter.args" = [ "-l120" "-tpy311" ];
      "python.testing.pytestEnabled" = true;
      "python.testing.pytestPath" = "${pkgs.python3Packages.pytest}/bin/pytest";
      "python.venvPath" = "~/.cache/pypoetry/virtualenvs";
      "python.poetryPath" = "${pkgs.poetry}/bin/poetry";
      "python.analysis.autoImportCompletions" = true;

      "editor.inlineSuggest.enabled" = true;

      # Other
      "redhat.telemetry.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "extensions.autoUpdate" = false;
      "update.mode" = "none";
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
