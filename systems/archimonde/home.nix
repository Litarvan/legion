{ pkgs, ... }:

{
  legion.wallpapers = [
    (root + /statics/wallpapers/wow_4.jpg)
    (root + /statics/wallpapers/wow_3.jpg)
  ];

  home.packages = with pkgs; [
    # TODO: Should we keep it?
    arc-kde-theme papirus-icon-theme
  ];
}
