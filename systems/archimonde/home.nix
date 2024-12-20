{ root, pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [
    jetbrains.idea-ultimate
    nodejs_22
  ];

  programs.alacritty.settings.window = {
    position = {
      x = 1800;
      y = 700;
    };
    dimensions = {
      lines = 80;
      columns = 250;
    };
  };

  legion.wallpapers = [
    (root + /statics/wallpapers/wow_3.jpg)
    (root + /statics/wallpapers/wow_4.jpg)
  ];

  xsession.windowManager.i3.config = {
    gaps = {
      inner = 9;
      outer = 6;
    };

    defaultWorkspace = "2";
    workspaceOutputAssign = [
      {
        workspace = "1";
        output = "DP-2";
      }
      {
        workspace = "2";
        output = "DP-1";
      }
      {
        workspace = "3";
        output = "DP-1";
      }
      {
        workspace = "4";
        output = "DP-1";
      }

      {
        workspace = "5";
        output = "DP-2";
      }

      {
        workspace = "6";
        output = "DP-1";
      }
    ];
  };
}
