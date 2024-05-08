{ pkgs, nixpkgs-unstable, self, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable {
        system = pkgs.system;
        # config.allowUnfree = true;
      };
    })

    self.overlays.default
  ];
}
