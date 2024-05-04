{ ... }:

{
  services.i2pd = {
    enable = true;
    enableIPv6 = true;
    proto.http.enable = true;
    proto.httpProxy.enable = true;
    proto.httpProxy.outproxy = "http://acetone.i2p:8888";
    proto.httpProxy.inbound.length = 1;
    proto.httpProxy.outbound.length = 1;
  };
}

