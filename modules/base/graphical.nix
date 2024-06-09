{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  services = {
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
  };

  programs = {
    dconf.enable = true;
    vim.defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    roboto
    noto-fonts-emoji-blob-bin
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
