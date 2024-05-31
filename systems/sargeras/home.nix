{ root, ... }:

{
  legion.wallpapers = [
    (root + /statics/wallpapers/wow_3.jpg)
    (root + /statics/wallpapers/wow_1.png)
  ];

  xsession.windowManager.i3.config.workspaceOutputAssign = [
    {
      workspace = "1";
      output = "HDMI-1";
    }
    {
      workspace = "2";
      output = "HDMI-1";
    }
    {
      workspace = "3";
      output = "HDMI-1";
    }
    {
      workspace = "4";
      output = "HDMI-1";
    }

    {
      workspace = "5";
      output = "eDP-1";
    }

    {
      workspace = "6";
      output = "HDMI-1";
    }
  ];

  programs.fish =
    let
      stockly_repo = "$HOME/Stockly/Main";
    in
    {
      functions.cdr = ''cd "${stockly_repo}/$argv"'';
      shellInit = ''
        complete --no-files --exclusive --command cdr --arguments "(pushd ${stockly_repo}; __fish_complete_directories; popd)"
      '';
    };
}
