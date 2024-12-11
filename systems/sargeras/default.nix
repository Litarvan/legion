{ lib, ... }:

{
  imports = [
    (lib.legion.homeModules [
      # TODO: Improve
      (import ./home.nix)
    ])
  ];

  # networking.hostName = "sargeras";

  # services.postgresql.enable = true;
  # virtualisation.docker.enable = true;

  # defaults write -g ApplePressAndHoldEnabled -bool false

  nix.settings.max-jobs = 10;

  system.stateVersion = 5;
}
