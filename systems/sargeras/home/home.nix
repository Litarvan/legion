{ pkgs, pkgsUnstable, ... }:

{
  home.packages = (with pkgs; [
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

    powerline-fonts
    noto-fonts-emoji
    jetbrains-mono

    discord
    slack
    spotify
    krita
    spectacle
  ]) ++ (with pkgsUnstable; [
    jetbrains.clion
    jetbrains.datagrip
  ]);

  programs = {
    firefox.enable = true;

    fish =
      let
        stockly_repo = "$HOME/Stockly/Main";
      in
      {
        functions = {
          cdr = ''cd "${stockly_repo}/$argv"'';
          fish_user_key_bindings = ''
            for mode in insert default visual
              bind -M $mode \cf forward-char
            end
          '';
        };
        shellInit = ''
          complete --no-files --exclusive --command cdr --arguments "(pushd ${stockly_repo}; __fish_complete_directories; popd)"
          fish_vi_key_bindings
        '';
      };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gpg = {
      enable = true;
      publicKeys = [{ source = ./litarvan.pub.gpg; }];
    };
    git = {
      enable = true;

      userName = "Adrien Navratil";
      userEmail = "id" + "@" + "litarvan.com";

      signing = {
        key = "056C26AAB0E33515";
        signByDefault = true;
      };
    };
  };

  services.gpg-agent = {
    enable = true;

    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
}
