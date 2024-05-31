{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
    # CLIs
    htop
    zip
    unzip
    file
    lz4
    patchelf
    unrar
    findutils
    imagemagick
    p7zip

    # Fonts
    powerline-fonts
    noto-fonts-emoji
    jetbrains-mono

    # Apps
    discord
    slack
    spotify
    krita
    spectacle
  ]) ++ (with pkgsUnstable; [
    # Apps (unstable)
    jetbrains.clion
    jetbrains.datagrip
  ]);

  # Apps (options)
  programs.firefox.enable = true;
}