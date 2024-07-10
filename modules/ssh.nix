{ ... }:

{
  services.openssh.openFirewall = false;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };
}
