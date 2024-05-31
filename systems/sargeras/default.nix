{ lib, pkgs, ... }:

{
  imports = [
    (lib.legion.homeModules [
      ./home
    ])
  ];

  legion = {
    cpu.intel.enable = true;
    nvme.enable = true;
    bluetooth.enable = true;
    touchpad.enable = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" ];

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
  system.stateVersion = "23.11";
}
