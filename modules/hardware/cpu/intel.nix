{ config, lib, ... }:

{
  options.legion.cpu.intel.enable = lib.mkEnableOption "Full Intel CPU support";

  config = lib.mkIf config.legion.cpu.intel.enable {
    boot = {
      initrd.availableKernelModules = lib.mkIf config.legion.nvme.enable [ "vmd" ];
      kernelModules = [ "kvm-intel" ];
    };

    hardware.cpu.intel.updateMicrocode = true;
    services.thermald.enable = true;
  };
}
