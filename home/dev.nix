{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    rnix-lsp
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      serayuzgur.crates
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "even-better-toml";
        publisher = "tamasfe";
        version = "0.16.5";
        sha256 = "pRUiXsZGhTIQx2Qx9NFQ7OGRros3KdzjUlq13nm4pAc=";
      }
      {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.4.1143";
        sha256 = "nRtRSbGVsT47LYY6mdL0v9fvR8inj+benNJUPJdbVEs=";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "0.6.1";
        sha256 = "5/Tqpn/7byl+z2ATflgKV1+rhdqj+XMEZNbGwDmGwLQ=";
      }
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";

      "files.autoSave" = "afterDelay";
      "diffEditor.ignoreTrimWhitespace" = false;

      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "cofob";
    userEmail = "cofob@riseup.net";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
