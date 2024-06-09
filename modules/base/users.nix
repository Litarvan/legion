{ config, lib, pkgs, root, ... }:

{
  users.users = {
    root.shell = pkgs.fish;

    litarvan = {
      description = "Adrien Navratil";
      isNormalUser = true;
      extraGroups = [ "wheel" ]
        ++ lib.optionals (config.virtualisation.virtualbox.host.enable) [ "vboxusers" ]
        ++ lib.optionals (config.virtualisation.docker.enable) [ "docker" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [ (builtins.readFile (root + /statics/litarvan.ed25519.pub.ssh)) ];
    };
  };

  programs = {
    fish.enable = true;
    starship.enable = true;
    command-not-found.enable = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.litarvan = {
      home = {
        username = "litarvan";
        homeDirectory = "/home/litarvan";

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
