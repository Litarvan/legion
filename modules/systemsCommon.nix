{ config, lib, pkgs, root, isDarwin, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;
    settings.extra-experimental-features = [ "flakes" "nix-command" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  programs = {
    fish.enable = true;
    vim.enable = true;
    # Starship? Vim default editor?
  };

  users.users = {
    root.shell = pkgs.fish;

    litarvan = {
      description = "Adrien Navratil";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [ (builtins.readFile (root + /statics/litarvan.ed25519.pub.ssh)) ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.litarvan = {
      home = {
        username = "litarvan";
        homeDirectory = lib.mkForce (if isDarwin then "/Users/litarvan" else "/home/litarvan");

        stateVersion = lib.mkDefault config.system.stateVersion;
      };

      programs = {
        home-manager.enable = true;

        fish = {
          enable = true;
          interactiveShellInit = ''
            if [ ! -n $SHLVL ] || [ $SHLVL -le 1 ]
              clear
              echo
              ${lib.getExe pkgs.neofetch}
              echo
            end

            ${lib.getExe pkgs.starship} init fish | source
          '';
        };
      };
    };
  };
}