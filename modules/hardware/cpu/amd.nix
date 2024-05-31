{ config, lib, ... }:

{
  options.legion.cpu.amd.enable = lib.mkEnableOption "Full AMD CPU support";

  config = lib.mkIf config.legion.cpu.amd.enable {
    boot.kernelModules = [ "kvm-amd" ];
    hardware.cpu.amd.updateMicrocode = true;
  };
}
