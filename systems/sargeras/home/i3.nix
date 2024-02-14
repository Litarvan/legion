{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  
    config = rec {
      modifier = "Mod4";
      bars = [
        {
          position = "top";

          colors = {
            background = "#111111";
            focusedWorkspace = { background = "#78062a"; border = "#78062a"; text = "#ffffff"; };
          };
        }
      ];
		
      window.border = 0;
		
      gaps = {
        inner = 15;
        outer = 15;
      };

      focus.newWindow = "none";
    
      keybindings = lib.mkOptionDefault {
        # Handled with KDE since for some reason running alacritty like this alongside the i3 systemd service will destroy the shell environment, making it nearly unusable
        # "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Return" = null;
        "${modifier}+Shift+s" = "exec ${lib.getExe' pkgs.spectacle "spectacle"} -r";
      };
		
      startup = [
        {
          command = "${lib.getExe pkgs.feh} --bg-scale ${./wallpaper.png}";
          always = true;
          notification = false;
        }
        {
          command = lib.getExe pkgs.numlockx;
          always = true;
        }
        {
          command = "${lib.getExe pkgs.xorg.xmodmap} -e 'keycode 49 = less greater'";
          always = true;
        }
      ];
    };
  };
}
