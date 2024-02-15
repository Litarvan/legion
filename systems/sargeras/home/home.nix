{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
    htop zip unzip file lz4 patchelf unrar findutils imagemagick p7zip
    powerline-fonts noto-fonts-emoji jetbrains-mono
    discord slack spotify krita spectacle
  ]) ++ (with pkgsUnstable; [
    jetbrains.clion jetbrains.datagrip
  ]);

  programs = {
    firefox.enable = true;

    fish = {
      functions.cdr = ''cd "$HOME/stockly/Main/$argv"'';
      shellInit = ''
        complete --no-files --exclusive --command cdr --arguments "(pushd $HOME/stockly/Main; __fish_complete_directories; popd)"
      '';
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gpg = {
      enable = true;
      publicKeys = [ { source = ./litarvan.pub.gpg; } ];
    };

    git = {
      enable = true;

      userName = "Adrien Navratil";
      userEmail = "adrien1975" + "@" + "live.fr";

      signing = {
        key = "056C26AAB0E33515";
        signByDefault = true;
      };
    };
  };
  
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
  };
}
