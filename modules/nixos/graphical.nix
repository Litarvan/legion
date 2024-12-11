{ lib, pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;

  services = {
    avahi.enable = true; # Chromecast support
    printing.enable = true;

    xserver = {
      enable = true;

      xkb = {
        layout = "fr";
        options = "eurosign:e";
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm; # KDE 6 instead of 5
      };
      defaultSession = "plasmax11";
    };
    desktopManager.plasma6.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    udev.packages = with pkgs; [
      via
    ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    roboto
    noto-fonts-emoji-blob-bin
    via
    kdePackages.sddm-kcm 
  ];

  systemd.user.services = {
    i3 = {
      description = "i3 window manager";
      wantedBy = [ "plasma-workspace.target" ];
      before = [ "plasma-workspace.target" ];
      serviceConfig = {
        ExecStart = pkgs.lib.getExe' pkgs.i3-gaps "i3";
        Restart = "on-failure";
      };
    };

    plasma-kwin_x11 = {
      wantedBy = lib.mkForce [ ];
      serviceConfig = {
        ExecStart = pkgs.lib.getExe' pkgs.coreutils "true";
      };
    };
  };
}
