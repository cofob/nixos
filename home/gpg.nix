{ ... }:

{
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;
  services.gpg-agent.sshKeys = [ "C2BC41ABFFF6232EA1082DAAF223487B7D7C984F" ];
}
