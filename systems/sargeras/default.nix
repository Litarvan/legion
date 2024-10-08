{ lib, pkgs, ... }:

{
  imports = [
    (lib.legion.homeModules [
      # TODO: Improve
      (import ./home.nix)
    ])
  ];

  legion = {
    cpu.intel.enable = true;
    gpu.nvidia = {
      enable = true;
      laptop = true;
    };
    nvme.enable = true;
    bluetooth.enable = true;
    touchpad.enable = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];

      luks.devices.sargeras_crypt = {
        device = "/dev/disk/by-label/sargeras_crypt";
        preLVM = true;
        allowDiscards = true;
      };
    };

    kernelModules = [ "dm-mod" "dm-crypt" "hid-apple" ];
  };

  fileSystems = {
    "/" = {
      label = "sargeras_root";
      fsType = "ext4";
    };

    "/efi" = {
      label = "SGRS_EFI";
      fsType = "vfat";
    };
  };

  networking.hostName = "sargeras";

  services.postgresql.enable = true;
  virtualisation.docker.enable = true;

  nix.settings.max-jobs = 12;

  system.stateVersion = "24.05";
}
