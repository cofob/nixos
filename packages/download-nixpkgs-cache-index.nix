{ writeShellScriptBin, busybox, wget, ... }:

writeShellScriptBin "download-nixpkgs-cache-index" ''
  filename="index-$(${busybox}/bin/uname -m | ${busybox}/bin/sed 's/^arm64$/aarch64/')-$(${busybox}/bin/uname | ${busybox}/bin/tr A-Z a-z)"
  ${busybox}/bin/mkdir -p ~/.cache/nix-index && cd ~/.cache/nix-index
  # -N will only download a new version if there is an update.
  ${wget}/bin/wget -q -N https://github.com/nix-community/nix-index-database/releases/latest/download/$filename
  ${busybox}/bin/ln -f $filename files
''
