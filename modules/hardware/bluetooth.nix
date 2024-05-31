{ config, lib, ... }:

{
  options.legion.bluetooth.enable = lib.mkEnableOption "Full Bluetooth support";

  config = lib.mkIf config.legion.bluetooth.enable {
     hardware.bluetooth = {
       enable = true;
       powerOnBoot = true;
     };

     environment.etc = {
       "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
         bluez_monitor.properties = {
           ["bluez5.enable-sbc-xq"] = true,
           ["bluez5.enable-msbc"] = true,
           ["bluez5.enable-hw-volume"] = true,
           ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
         }
       '';
     };
  };
}