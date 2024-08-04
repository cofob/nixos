{ pkgs, self, nixos-x13s, system, ... }@inputs:

{
  imports = [
    ((import "${nixos-x13s}/module.nix" {
      dtbName = "sc8280xp-lenovo-thinkpad-x13s.dtb";
    } ({
      pkgs = (import inputs.nixos-x13s.inputs.nixpkgs { inherit system; });
    } // inputs)))

    "${self}/hardware/twinkpad.nix"

    "${self}/modules/common.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/bluetooth.nix"
    "${self}/modules/dns-server.nix"
    "${self}/modules/gui.nix"
    "${self}/modules/sway.nix"
    "${self}/modules/i2pd.nix"
    "${self}/modules/tor.nix"
    "${self}/modules/yggdrasil.nix"
    "${self}/modules/libvirt.nix"
  ];

  nixos-x13s.enable = true;
  nixos-x13s.bluetoothMac = "02:68:b3:29:da:98";
  nixos-x13s.kernel = "jhovold";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cofob = import ./home.nix { inherit self; };

  networking.hostName = "twinkpad";

  services.openssh.enable = true;

  custom.syncthing.enable = true;

  services.tailscale.enable = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  virtualisation.docker.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  users.users.cofob.extraGroups = [ "networkmanager" ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  # Open ssh port
  networking.firewall.interfaces.ztwfuehebm.allowedTCPPorts = [ 22 ];
}
