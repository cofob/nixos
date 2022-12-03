{ config, pkgs, lib, ... }:

{
  imports = [ ./mullvad.nix ];

  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      windowManager.i3.configFile = ./configs/i3.txt;
      displayManager.sddm.enable = true;
      xkbOptions = "grp:caps_toggle";
      layout = "us,ru";
    };

    gnome.gnome-keyring.enable = true;

    hardware.bolt.enable = false;

    pipewire.enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11"
    "nvidia-settings"
  ];

  programs.gnupg.agent.pinentryFlavor = "qt";

  hardware.opengl.enable = true;

  fonts.fonts = with pkgs; [
    fira-code-symbols
    noto-fonts-emoji
    noto-fonts-cjk
    liberation_ttf
    proggyfonts
    noto-fonts
    fira-code
    dina-font
  ];
  fonts.fontconfig.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;

  services.mullvad-vpn-custom.enable = true;

  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    user = "cofob";
    dataDir = "/home/cofob";
    systemService = true;
    folders = {
      "/home/cofob/Documents/Learning" = {
        id = "documents-learning";
        devices = [ "huawei" ];
        versioning = {
          type = "simple";
          params.keep = "10";
        };
      };
      "/home/cofob/Documents/Dev" = {
        id = "documents-dev";
        devices = [ "huawei" "bear" "fly" "rat" ];
        versioning = {
          type = "simple";
          params.keep = "3";
        };
      };
      "/home/cofob/Music" = {
        id = "music";
        devices = [ "huawei" ];
        versioning = {
          type = "simple";
          params.keep = "10";
        };
      };
    };
    devices = {
      huawei = {
        id = "V3DPTUO-ESKOTAG-4QK5BH2-ZAVFNQI-RTLGIXX-KBYJ5NM-JPXGRDU-GTTOAQH";
      };
      bear = {
        id = "V4RGEPV-66RY2EP-DKMWW3J-ADAC7TD-CLYEEKM-XZ2YQFJ-AGCHHAP-CZ32XQB";
      };
      fly = {
        id = "FP4SSU3-OZJLAY4-X25CHCU-TK34OZ3-CPY2CK6-CGPFJOS-H4VHSY2-5VTHSA5";
      };
      rat = {
        id = "6HBRNZZ-G2AWAYD-4DEF6KC-HYNXAG7-WMXSEVO-4FGJHBX-BH2XMN2-CQTW7QI";
      };
    };
  };
}
