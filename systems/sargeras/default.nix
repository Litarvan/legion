{ pkgs, ... }:

{
  imports = [
    ./home
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "vmd" "xhci_pci" "nvme" ];

      luks.devices.sargeras_crypt = {
        device = "/dev/disk/by-label/sargeras_crypt";
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelModules = [ "kvm-intel" "dm-mod" "dm-crypt" ];

    loader = {
      systemd-boot.enable = true;
      efi = {
        efiSysMountPoint = "/efi";
        canTouchEfiVariables = true;
      };
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.package = pkgs.pulseaudioFull;
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

  networking = {
    hostName = "sargeras";
    networkmanager.enable = true;
  };

  services = {
    fstrim.enable = true;
    thermald.enable = true;

    postgresql.enable = true;
  };

  virtualisation.docker.enable = true;

  nix.settings.max-jobs = 12;

  system.stateVersion = "23.11";
}
