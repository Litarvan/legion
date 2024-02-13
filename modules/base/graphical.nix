{ config, lib, pkgs, ... }:

{
  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
  };

  programs.dconf.enable = true;

  services = {
    printing.enable = true;

    xserver = {
      enable = true;

      libinput = {
        enable = true;

        touchpad = {
          disableWhileTyping = true;
          tappingButtonMap = "lrm";
        };
      };

      xkb = {
        layout = "fr";
        options = "eurosign:e,caps:swap_escape";
      };

      displayManager.gdm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };

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
