{ lib, pkgs, ... }: {
  wayland.windowManager.sway.enable = true;
  xdg.configFile."sway/config".source = lib.mkForce ./configs/sway.txt;

  programs.waybar.enable = true;
  xdg.configFile."waybar/config".source = lib.mkForce ./configs/waybar.jsonh;

  services.mako.enable = true;
  services.mako.defaultTimeout = 5000;

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = {}
      config.font = wezterm.font {
        family = 'Monaspace Neon',
        harfbuzz_features = { 'calt=1', 'dlig=1', 'liga=1', 'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1' },
      }
      config.enable_tab_bar = false
      config.hide_mouse_cursor_when_typing = false
      config.color_scheme = 'DimmedMonokai'
      return config
    '';
  };
  programs.fuzzel.enable = true;

  home.packages = let
    mkScreenshotSctipt = name: copy-command:
      pkgs.writeShellScriptBin name ''
        relative="Pictures/Screenshots/$(date '+%Y/%m/%d')"
        folder="$HOME/Pictures/Screenshots/$(date '+%Y/%m/%d')"
        mkdir -p "$folder"

        name="$(date '+%H-%M-%S').png"
        out="$folder/$name"
        ${copy-command}

        ${pkgs.wl-clipboard}/bin/wl-copy -t image/png < "$out"

        ${pkgs.notify-desktop}/bin/notify-desktop -t 3000 -a "Screenshot" "Screenshot copied and saved to ~/$relative/$name"
      '';
  in with pkgs; [
    pulseaudio # audio volume control
    light # light control
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    (mkScreenshotSctipt "screenshot" ''${pkgs.grim}/bin/grim "$out"'')
    (mkScreenshotSctipt "screenshot-area"
      ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" "$out"'')
  ];
}
