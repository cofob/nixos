{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Disable = "Headset";
      };
    };
  };
  services.blueman.enable = true;
}

