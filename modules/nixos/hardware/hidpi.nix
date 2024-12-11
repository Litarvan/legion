{ config, lib, pkgs, ... }:

{
  options.legion.hidpi.enable = lib.mkEnableOption "Better HiDPI support";

  config = lib.mkIf config.legion.hidpi.enable {
    console = {
      font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
      earlySetup = true;
    };

    fonts.fontconfig = {
      antialias = true;
      subpixel = {
        rgba = "none";
        lcdfilter = "none";
      };
    };
  };
}
