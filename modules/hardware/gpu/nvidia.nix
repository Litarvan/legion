{ config, lib, pkgs, ... }:

{
  options.legion.gpu.nvidia = {
    enable = lib.mkEnableOption "Full Nvidia GPU support";
    laptop = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable Optimus/PRIME support";
      default = false;
    };
  };

  config = lib.mkIf config.legion.gpu.nvidia.enable {
    # NVIDIA does not support the latest kernel
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_10;

    hardware.nvidia = lib.mkMerge [
      {
        open = true;
      }

      (lib.mkIf config.legion.gpu.nvidia.laptop {
        prime = {
          sync.enable = true;

          intelBusId = lib.mkDefault "PCI:0:2:0";
          nvidiaBusId = lib.mkDefault "PCI:1:0:0";
        };

        modesetting.enable = true;
      })
    ];

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
