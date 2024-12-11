{ config, lib, ... }:

{
  options.legion.touchpad.enable = lib.mkEnableOption "Full touchpad support";

  config = lib.mkIf config.legion.touchpad.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        tappingButtonMap = "lrm";
      };
    };
  };
}
