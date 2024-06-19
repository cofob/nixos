{ writeShellScriptBin, ... }:

writeShellScriptBin "yubikey-waybar" (builtins.readFile ./script.sh)
