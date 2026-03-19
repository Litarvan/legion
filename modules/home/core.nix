{ pkgs, root, isDarwin, ... }:

{
  home.sessionPath = [ "$HOME/.npm/prefix/bin" ];

  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        navigate = true;
        dark = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

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
      shellAbbrs.legion-rebuild = "sudo ${if isDarwin then "nix run ~/legion#darwin-rebuild --" else "nixos-rebuild"} -L --show-trace --flake ~/legion";
    };

    git = {
      enable = true;

      settings = {
        merge.conflictstyle = "diff3";
        user = {
          name = "Adrien Navratil";
          email = "id" + "@" + "litarvan.com";
        };
      };

      # Key expired; commenting until migrating to the new one
      # signing = {
      #   key = "056C26AAB0E33515";
      #   signByDefault = true;
      # };
    };

    gpg = {
      enable = true;
      publicKeys = [{ source = root + /statics/litarvan.pub.gpg; }];
    };

    nix-index.enable = true;

    starship.enable = isDarwin; # On NixOS, it's enabled system-wide
  };

  services.gpg-agent = {
    enable = true;

    enableSshSupport = true;
    pinentry.package = if isDarwin then pkgs.pinentry_mac else pkgs.pinentry-qt;
  };
}
