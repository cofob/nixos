let
  cofob =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsSKOtKRM9+bvCs6iioOrcayMdsdwaQN/lJAQJkXE+w";
  users = [ cofob ];

  husky =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFrYiKbERa6EiZHSBBQvjME2qAMowHimuXb+KOUS8Rn";
  systems = [ husky ];

  all = users ++ systems;
in { "./passwords/cofob.age".publicKeys = all; }
