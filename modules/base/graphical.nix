{ ... }:

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
}