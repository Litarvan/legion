{ pkgs, pkgsUnstable, root, ... }:

{
  programs = {
    fish = {
      shellInit = ''
        fish_vi_key_bindings
      '';

      functions = {
        fish_user_key_bindings = ''
          for mode in insert default visual
            bind -M $mode \cf forward-char
          end
        '';
      };
      shellAbbrs.legion-rebuild = "sudo nixos-rebuild -L --show-trace --flake ~/legion";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gpg = {
      enable = true;
      publicKeys = [{ source = root + /statics/litarvan.pub.gpg; }];
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
