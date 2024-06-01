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
            command = "kill";
          }
          {
            criteria.title = "plasmashell";
            command = "floating enable; border none";
          }
        ];
      };

      gaps = {
        inner = lib.mkDefault 6;
        outer = lib.mkDefault 6;
      };

      focus = {
        newWindow = "focus";
        mouseWarping = false;
        followMouse = false;
      };

      workspaceAutoBackAndForth = true;
      workspaceLayout = "stacking";

      assigns = {
        "1" = [{ class = "^discord$"; }];
        "2" = [{ class = "^firefox$"; }];
        "3" = [{ class = "^jetbrains-idea$"; }];
        "5" = [{ class = "^spotify$"; }];
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = null;
        "${modifier}+d" = null;

        # Handled with KDE since for some reason running alacritty like this alongside the i3 systemd service will
        # destroy the shell environment, making it nearly unusable
        #
        # "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

        "${modifier}+Shift+s" = "exec ${lib.getExe' pkgs.kdePackages.spectacle "spectacle"} -r";
        "${modifier}+Shift+e" = "exec ${lib.getExe' pkgs.kdePackages.qttools "qdbus"} org.kde.LogoutPrompt /LogoutPrompt org.kde.LogoutPrompt.promptShutDown";
      };

      startup = [
        {
          command = builtins.concatStringsSep
            " "
            ([ "${lib.getExe pkgs.feh} " ] ++ (map (path: "--bg-fill ${path}") config.home-manager.users.litarvan.legion.wallpapers)); # TODO: X D
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
