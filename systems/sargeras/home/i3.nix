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
        "${modifier}+Return" = null;
        # "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+Return" = null;
        "${modifier}+Shift+s" = "exec ${pkgs.spectacle}/bin/spectacle -r";
      };
		
      startup = [
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ${./wallpaper.png}";
          always = true;
          notification = false;
        }

        {
          command = "${pkgs.numlockx}/bin/numlockx";
          always = true;
        }
      ];
    };
  };
}
