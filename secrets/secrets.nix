let
  cofob-twinkpad =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzB+g6qthKy95lG3UxnikrHCaVZ9O9njEqzdCIIfXxL cofob@twinkpad";
  cofob-yubi =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsSKOtKRM9+bvCs6iioOrcayMdsdwaQN/lJAQJkXE+w";
  cofob = [ cofob-twinkpad cofob-yubi ];
  users = cofob;

  husky = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFrYiKbERa6EiZHSBBQvjME2qAMowHimuXb+KOUS8Rn"
  ];
  twinkpad = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcgBUw3N8+F9qvcMd6GWHYEtmquY5HsIGOCsS9pcCsP"
  ];
  systems = husky ++ twinkpad;

  all = users ++ systems;
in {
  "./passwords/cofob.age".publicKeys = all;

  "./syncthing/husky/key.age".publicKeys = users ++ husky;
  "./syncthing/husky/cert.age".publicKeys = users ++ husky;
  "./syncthing/twinkpad/key.age".publicKeys = users ++ twinkpad;
  "./syncthing/twinkpad/cert.age".publicKeys = users ++ twinkpad;
}
