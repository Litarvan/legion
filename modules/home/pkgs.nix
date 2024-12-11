{ lib, pkgs, pkgsUnstable, isDarwin, ... }:

{
  home.packages = (
    # Common
    with pkgs; [
      # CLIs
      bat
      delta
      file
      findutils
      htop
      imagemagick
      jq
      lz4
      nixd
      nixpkgs-fmt
      nodejs_22
      p7zip
      patchelf
      rustup
      unrar
      unzip
      zip
    ]
  ) ++ (lib.optionals (!isDarwin) (
    # Linux only
    (with pkgs; [
      # CLIs
      lm_sensors

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
      vscode-fhs
      wireshark

      # Themes
      arc-kde-theme
      papirus-icon-theme
    ]) ++ (with pkgsUnstable; [
      # Apps (unstable)
      jetbrains.clion
      jetbrains.datagrip
    ])
  ));

  # Apps (options)
  programs.firefox.enable = !isDarwin;
}
