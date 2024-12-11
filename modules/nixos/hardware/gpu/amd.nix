{ config, lib, pkgs, ... }:

{
  options.legion.gpu.amd.enable = lib.mkEnableOption "Full AMD GPU support";

  config = lib.mkIf config.legion.gpu.amd.enable {
    boot.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

    services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];
  };
}
