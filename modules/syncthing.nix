{ config, lib, self, ... }:

let
  cfg = config.custom.syncthing;
  machine = config.networking.hostName;

  machine-ids = {
    husky = "F3AWR4N-QH2BEOM-XVIAL5C-CSUC5U6-OFQZQUC-7MN4RJ5-2D4XEXU-JH4DEQB";
    twinkpad =
      "FOKHYOX-FGM624F-BWUKMFQ-OR6LJ67-IA5TVOO-XNNF7PM-YZFHBGE-BXEU3AF";
  };
  filteredDevices = lib.filterAttrs (name: value: name != machine) machine-ids;
in {
  options.custom.syncthing = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable syncthing service";
    };
  };

  config = lib.mkIf cfg.enable {
    age.secrets."syncthing-cert-${machine}" = {
      file = "${self}/secrets/syncthing/${machine}/cert.age";
      owner = "cofob";
    };
    age.secrets."syncthing-key-${machine}" = {
      file = "${self}/secrets/syncthing/${machine}/key.age";
      owner = "cofob";
    };

    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "cofob";
      group = "users";
      dataDir = "/home/cofob";
      key = config.age.secrets."syncthing-key-${machine}".path;
      cert = config.age.secrets."syncthing-cert-${machine}".path;
      settings = {
        options.urAccepted = -1;
        overrideDevices = true;
        overrideFolders = false;

        devices = lib.mapAttrs (name: id: {
          inherit id;
          inherit name;
          autoAcceptFolders = true;
        }) filteredDevices;
      };
    };
  };
}
