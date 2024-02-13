{ config, lib, pkgs, ... }:

{
  users.users = {
    root.shell = pkgs.fish;

    litarvan = {
      description = "Adrien Navratil";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoFiziKbq1TVgaiSp4SioutOG78WSkbJrrIYrKEYM5H cardno:16 097 343"
      ];
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
        # command-not-found.enable = true;

        fish = {
          enable = true;
          interactiveShellInit = ''
            clear
            echo
            ${lib.getExe pkgs.neofetch}
            echo

            ${lib.getExe pkgs.starship} init fish | source
          '';
        };
      };
    };
  };
}
