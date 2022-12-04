{ config, pkgs, lib, ... }:

{
  imports = [ ./mullvad.nix ];

  options = {
    defaultApplications = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config = {
    services = {
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
        xkbOptions = "grp:caps_toggle";
        layout = "us,ru";
      };

      gnome.gnome-keyring.enable = true;

      hardware.bolt.enable = false;

      pipewire.enable = true;
    };

    xdg.mime = {
      enable = true;
      defaultApplications = with config.defaultApplications;
        builtins.mapAttrs
          (name: value:
            if value ? desktop then [ "${value.desktop}.desktop" ] else value)
          {
            "inode/directory" = fm;
            "text/html" = browser;
            "image/*" = { desktop = "org.gnome.eog"; };
            "application/zip" = archive;
            "application/rar" = archive;
            "application/7z" = archive;
            "application/*tar" = archive;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/mailto" = mail;
            "x-scheme-handler/matrix" = matrix;
            "application/pdf" = { desktop = "org.kde.okular"; };
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
              text_processor;
            "application/msword" = text_processor;
            "application/vnd.oasis.opendocument.text" = text_processor;
            "text/csv" = spreadsheet;
            "application/vnd.oasis.opendocument.spreadsheet" = spreadsheet;
            "text/plain" =
              editor; # This actually makes Emacs an editor for everything... XDG is wierd
          };
    };

    defaultApplications = {
      matrix = {
        cmd = "${pkgs.nheko}/bin/nheko";
        desktop = "nheko";
      };
      browser = {
        cmd = "${pkgs.firefox}/bin/firefox";
        desktop = "firefox";
      };
      mail = {
        cmd = "${pkgs.gnome.geary}/bin/geary";
        desktop = "org.gnome.Geary";
      };
      fm = {
        cmd = "${pkgs.dolphin}/bin/dolphin";
        desktop = "org.kde.dolphin";
      };
      editor = {
        cmd = "${pkgs.neovim}/bin/nvim";
        desktop = "org.vim.Nvim";
      };
      text_processor = {
        cmd = "${pkgs.libreoffice}/bin/libreoffice";
        desktop = "libreoffice-startcenter";
      };
      spreadsheet = {
        cmd = "${pkgs.libreoffice}/bin/libreoffice";
        desktop = "libreoffice-startcenter";
      };
      archive = {
        cmd = "${pkgs.gnome.file-roller}/bin/file-roller";
        desktop = "org.gnome.FileRoller";
      };
    };

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
      enable = false;
      user = "cofob";
      dataDir = "/home/cofob";
      systemService = true;
      folders = {
        # "/home/cofob/Documents/Learning" = {
        #   id = "documents-learning";
        #   devices = [ "huawei" "bear" "fly" "husky" ];
        #   versioning = {
        #     type = "simple";
        #     params.keep = "10";
        #   };
        # };
        # "/home/cofob/Documents/Dev" = {
        #   id = "documents-dev";
        #   devices = [ "huawei" "bear" "fly" "rat" "husky" ];
        #   versioning = {
        #     type = "simple";
        #     params.keep = "3";
        #   };
        # };
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
        husky = {
          id = "FEOUI4J-X7L42A5-37T5YIT-MWW7S2E-B6ORUXS-5OOTJRB-EAVL7QW-QFPK3QG";
        };
      };
    };
  };
}
