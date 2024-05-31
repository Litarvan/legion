{ config, pkgs, lib, root, ... }:

{
  options.legion.wallpapers = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    description = "Wallpapers paths";
  };

  config.xsession.windowManager.i3 = {
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

      window = {
        border = 0;
        commands = [
          # Kills the wallpaper windows popping on startup
          {
            criteria.title = "Desktop @ QRect.*";
            command = "kill; floating enable; border none";
          }
        ];
      };

      gaps = {
        inner = 15;
        outer = 15;
      };

      focus = {
        newWindow = "none";
        mouseWarping = false;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = null;
        "${modifier}+d" = null;

        # Handled with KDE since for some reason running alacritty like this alongside the i3 systemd service will
        # destroy the shell environment, making it nearly unusable
        #
        # "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

        "${modifier}+Shift+s" = "exec ${lib.getExe' pkgs.spectacle "spectacle"} -r";
        "${modifier}+Shift+e" = "exec ${lib.getExe' pkgs.qt5.qttools "qdbus"} org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1";
      };

      startup = [
        {
          command = builtins.concatStringsSep
            " "
            ([ "${lib.getExe pkgs.feh} " ] ++ (map (path: "--bg-scale ${path}") config.home-manager.users.litarvan.legion.wallpapers)); # TODO: X D
          always = true;
          notification = false;
        }
        {
          command = lib.getExe pkgs.numlockx;
          always = true;
        }
      ];
    };
  };
}
