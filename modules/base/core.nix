{ lib, modulesPath, pkgs, ... }:

{
  boot = {
    # TODO: Put back when https://github.com/NixOS/nixpkgs/pull/311362 is merged and backported
    # kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];

    loader = {
      efi = {
        efiSysMountPoint = "/efi";
        canTouchEfiVariables = true;
      };
      systemd-boot.enable = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  console = {
    keyMap = "fr";
    font = lib.mkDefault "Lat2-Terminus16";
  };

  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
    };
  };

  networking = {
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  security = {
    protectKernelImage = true;
    rtkit.enable = true;
  };

  environment.systemPackages = with pkgs; [ vim git curl ];

  nix = {
    package = pkgs.nixVersions.latest;
    settings.extra-experimental-features = [ "flakes" "nix-command" ];
  };
}
