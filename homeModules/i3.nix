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
        inner = lib.mkDefault 15;
        outer = lib.mkDefault 10;

        # Plasma 6 floating bar already has a transparent zone acting as bottom gaps
        bottom = 0;
      };

      focus = {
        newWindow = "focus";
        mouseWarping = false;
        followMouse = false;
      };

      defaultWorkspace = lib.mkDefault "1";
      workspaceAutoBackAndForth = true;
      workspaceLayout = "stacking";

      assigns = {
        "1" = [{ class = "^discord$"; }];
        "2" = [{ class = "^firefox$"; }];
        "3" = [{ class = "^jetbrains-idea$"; }];
        "5" = [{ class = "^spotify$"; } { class = "^jetbrains-datagrip$"; }];
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
            ([ "${lib.getExe pkgs.feh} " ] ++ (map (path: "--bg-fill ${path}") config.legion.wallpapers));
          always = true;
          notification = false;
        }
        {
          command = lib.getExe pkgs.numlockx;
          always = true;
        }
      ];
    };

    # We want bottom gaps for workspaces without the Plasma bar
    extraConfig =
      let
        i3Config = config.xsession.windowManager.i3.config;
        mainScreen = (builtins.head (builtins.filter (assign: assign.workspace == i3Config.defaultWorkspace) i3Config.workspaceOutputAssign)).output;
      in
      builtins.concatStringsSep "\n"
        (map
          ({ workspace, ... }: "workspace ${workspace} gaps bottom ${toString i3Config.gaps.outer}")
          (builtins.filter (assign: assign.output != mainScreen) i3Config.workspaceOutputAssign));
  };
}
