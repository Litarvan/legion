{ lib, ... }:

{
  imports = [
    (lib.legion.homeModules [
      # TODO: Improve
      (import ./home.nix)
    ])
  ];

  system.primaryUser = "litarvan";

  # networking.hostName = "sargeras";

  # services.postgresql.enable = true;
  # virtualisation.docker.enable = true;

  # defaults write -g ApplePressAndHoldEnabled -bool false
  # defaults write .GlobalPreferences com.apple.mouse.scaling -1
  # defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled 0
  # https://github.com/paulmillr/encrypted-dns?tab=readme-ov-file

  nix.settings.max-jobs = 10;

  system.stateVersion = 5;
}
