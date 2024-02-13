{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
    htop zip unzip file lz4 patchelf unrar findutils imagemagick p7zip
    rustup
    powerline-fonts noto-fonts-emoji jetbrains-mono
    discord krita spectacle
  ]) ++ (with pkgsUnstable; [
    jetbrains.clion
  ]);

  programs.git = {
    enable = true;

    userName = "Adrien Navratil";
    userEmail = "adrien1975" + "@" + "live.fr";

    signing = {
      key = "056C26AAB0E33515";
      signByDefault = true;
    };
  };
  
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
  };
}