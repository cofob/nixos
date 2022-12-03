let
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ cofob ];

  bear = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxTTHyhhZTc6pw+p55FfRZeuUqvHLy4RGGcZD1m9Nbf";
  fly = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG6wT9ftCz7BiH8vViJpQ7BIh0exf2b5kJzUbAoyP/Pf";
  husky = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJC87IxPZgeFIEfiUbXppmzprk+qSq0IyOwJvOPQhh1Y";
  systems = [ bear fly husky ];
in
{
  "./passwords/cofob.age".publicKeys = users ++ systems;

  "./credentials/remote-builder.age".publicKeys = users ++ systems;

  "./wg/aeza/fly.age".publicKeys = users ++ [ fly ];

  "./nebula/ca-crt.age".publicKeys = users ++ systems;
  "./nebula/fly-crt.age".publicKeys = users ++ [ fly ];
  "./nebula/fly-key.age".publicKeys = users ++ [ fly ];
  "./nebula/bear-crt.age".publicKeys = users ++ [ bear ];
  "./nebula/bear-key.age".publicKeys = users ++ [ bear ];

  "./syncthing/bear-cert.age".publicKeys = users ++ [ bear ];
  "./syncthing/bear-key.age".publicKeys = users ++ systems;
  "./syncthing/fly-cert.age".publicKeys = users ++ systems;
  "./syncthing/fly-key.age".publicKeys = users ++ [ fly ];
  "./syncthing/husky-cert.age".publicKeys = users ++ systems;
  "./syncthing/husky-key.age".publicKeys = users ++ [ husky ];
}
