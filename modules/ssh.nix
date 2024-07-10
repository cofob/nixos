{ ... }:

{
  services.openssh.openFirewall = false;
  services.openssh.settings = {
    PermitRootLogin = false;
    PasswordAuthentication = false;
  };
}
