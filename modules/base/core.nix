{ modulesPath, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  console = {
    keyMap = "fr";
    font = "Lat2-Terminus16";
  };

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
  time.timeZone = "Europe/Paris";

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  security.protectKernelImage = true;
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [ vim git curl ];

  nix = {
    package = pkgs.nixVersions.nix_2_19;
    settings.extra-experimental-features = [ "flakes" "nix-command" "repl-flake" ];
  };
}
