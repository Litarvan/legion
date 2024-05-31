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

      displayManager.gdm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs.dconf.enable = true;

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
