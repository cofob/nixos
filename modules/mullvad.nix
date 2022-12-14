{ config, lib, pkgs, ... }:
let
  cfg = config.services.mullvad-vpn-custom;
  pkg = (pkgs.callPackage ../pkgs/mullvad.nix { });
in
with lib;
{
  options.services.mullvad-vpn-custom.enable = mkOption {
    type = types.bool;
    default = false;
    description = ''
      This option enables Mullvad VPN daemon.
      This sets <option>networking.firewall.checkReversePath</option> to "loose", which might be undesirable for security.
    '';
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [ "tun" ];
    environment.systemPackages = [ pkg ];

    # mullvad-daemon writes to /etc/iproute2/rt_tables
    networking.iproute2.enable = true;

    # See https://github.com/NixOS/nixpkgs/issues/113589
    networking.firewall.checkReversePath = "loose";

    systemd.services.mullvad-daemon = {
      description = "Mullvad VPN daemon";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network.target" ];
      after = [
        "network-online.target"
        "NetworkManager.service"
        "systemd-resolved.service"
      ];
      path = [
        pkgs.iproute2
        # Needed for ping
        "/run/wrappers"
      ];
      startLimitBurst = 5;
      startLimitIntervalSec = 20;
      serviceConfig = {
        ExecStart = "${pkg}/bin/mullvad-daemon -v --disable-stdout-timestamps";
        Restart = "always";
        RestartSec = 1;
      };
    };
  };

  meta.maintainers = with maintainers; [ ymarkus ];
}
