{ lib, isDarwin, ... }:

{
  programs.alacritty = {
    enable = !isDarwin;

    settings = {
      window = {
        title = "Terminal";

        position = {
          x = lib.mkDefault 900;
          y = lib.mkDefault 350;
        };
        dimensions = {
          lines = lib.mkDefault 40;
          columns = lib.mkDefault 125;
        };

        opacity = 0.6;
      };

      font = {
        normal.family = "Meslo LG S for Powerline";
        size = lib.mkDefault 10.0;
      };

      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xEBEBEB";
        };
        cursor = {
          text   = "0xFF261E";
          cursor = "0xFF261E";
        };
        normal = {
          black   = "0x0D0D0D";
          red     = "0xFF301B";
          green   = "0xA0E521";
          yellow  = "0xFFC620";
          blue    = "0x1BA6FA";
          magenta = "0x8763B8";
          cyan    = "0x21DEEF";
          white   = "0xEBEBEB";
        };
        bright = {
          black   = "0x6D7070";
          red     = "0xFF4352";
          green   = "0xB8E466";
          yellow  = "0xFFD750";
          blue    = "0x1BA6FA";
          magenta = "0xA578EA";
          cyan    = "0x73FBF1";
          white   = "0xFEFEF8";
        };
      };
    };
  };
}
