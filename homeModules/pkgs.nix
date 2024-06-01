{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
    # CLIs
    file
    findutils
    htop
    imagemagick
    lz4
    nixpkgs-fmt
    p7zip
    patchelf
    unrar
    unzip
    zip

    # Fonts
    jetbrains-mono
    noto-fonts-emoji
    powerline-fonts

    # Apps
    discord
    krita
    slack
    spectacle
    spotify
  ]) ++ (with pkgsUnstable; [
    # Apps (unstable)
    jetbrains.clion
    jetbrains.datagrip
  ]);

  # Apps (options)
  programs.firefox.enable = true;
}
