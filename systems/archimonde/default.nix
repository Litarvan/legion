{ lib, ... }:

{
  imports = [
    (lib.legion.homeModules [
      # TODO: Improve
      (import ./home.nix)
    ])
  ];

  legion = {
    cpu.amd.enable = true;
    gpu.amd.enable = true;
    nvme.enable = true;
    hidpi.enable = true;
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];

  fileSystems = {
    "/" = {
      label = "archimonde_root";
      fsType = "ext4";
    };

    "/efi" = {
      label = "ARMD_EFI";
      fsType = "vfat";
    };

    "/home" = {
      label = "archimonde_home";
      fsType = "ext4";
    };
  };

  networking.hostName = "archimonde";

  virtualisation = {
    docker.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  nix.settings.max-jobs = 16;

  system.stateVersion = "20.09";
}
