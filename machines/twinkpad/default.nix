{ pkgs, self, nixos-x13s, ... }:

{
  imports = [
    nixos-x13s.nixosModules.default
    "${self}/hardware/twinkpad.nix"
    "${self}/modules/common.nix"
    "${self}/modules/boot.nix"
    "${self}/modules/bluetooth.nix"
    "${self}/modules/dns-server.nix"
    "${self}/modules/gui.nix"
    "${self}/modules/sway.nix"
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cofob = import ./home.nix { inherit self; };

  networking.hostName = "twinkpad";

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  # Enable networking
  networking.networkmanager.enable = true;
  users.users.cofob.extraGroups = [ "networkmanager" ];

  # x13s-specific
  nixos-x13s.enable = true;
  nixos-x13s.kernel = "jhovold";

  specialisation = { mainline.configuration.nixos-x13s.kernel = "mainline"; };

  # allow unfree firmware
  nixpkgs.config.allowUnfree = true;

  # add x13s cache
  nix.settings = {
    substituters = [ "https://nixos-x13s.cachix.org" ];
    trusted-public-keys = [
      "nixos-x13s.cachix.org-1:SzroHbidolBD3Sf6UusXp12YZ+a5ynWv0RtYF0btFos="
    ];
  };
}
