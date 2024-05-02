let
  cofob =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ cofob ];

  husky =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFrYiKbERa6EiZHSBBQvjME2qAMowHimuXb+KOUS8Rn";
  systems = [ husky ];
in { "./passwords/cofob.age".publicKeys = users ++ systems; }
