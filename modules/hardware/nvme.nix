{ config, lib, ... }:

{
  options.legion.nvme.enable = lib.mkEnableOption "Full NVMe support";

  config = lib.mkIf config.legion.nvme.enable {
    boot.initrd.availableKernelModules = [ "nvme" ];
    services.fstrim.enable = true;
  };
}
