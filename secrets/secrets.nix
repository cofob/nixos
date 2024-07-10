let
  cofob =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsSKOtKRM9+bvCs6iioOrcayMdsdwaQN/lJAQJkXE+w";
  users = [ cofob ];

  husky =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFrYiKbERa6EiZHSBBQvjME2qAMowHimuXb+KOUS8Rn";
  twinkpad =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcgBUw3N8+F9qvcMd6GWHYEtmquY5HsIGOCsS9pcCsP";
  systems = [ husky twinkpad ];

  all = users ++ systems;
in { "./passwords/cofob.age".publicKeys = all; }
