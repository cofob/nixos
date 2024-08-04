{ ... }:

{
  services.yggdrasil = {
    enable = true;
    persistentKeys = false;
    settings = {
      IfName = "ygg0";
      NodeInfoPrivacy = true;
      Peers =
        [ "tcp://37.186.113.100:1514" "tcp://ygg-uplink.thingylabs.io:80" ];
    };
  };
}
