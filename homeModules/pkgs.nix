{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
    # CLIs
    bat
    delta
    file
    findutils
    htop
    imagemagick
    jq
    lm_sensors
    lz4
    nixpkgs-fmt
    nodejs_22
    p7zip
    patchelf
    rustup
    unrar
    unzip
    zip

    # Fonts
    jetbrains-mono
    noto-fonts-emoji
    powerline-fonts

    # Apps
    discord
    kdePackages.spectacle
    krita
    slack
    spotify
    wireshark

    # Themes
    arc-kde-theme
    papirus-icon-theme
  ]) ++ (with pkgsUnstable; [
    # Apps (unstable)
    jetbrains.clion
    jetbrains.datagrip
  ]);

  # Apps (options)
  programs.firefox.enable = true;
}
