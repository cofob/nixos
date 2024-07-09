{ vscode-extensions, ... }:

vscode-extensions.ms-python.python.overrideAttrs {
  meta.platforms =
    [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
}
