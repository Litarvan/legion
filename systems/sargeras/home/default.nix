{ ... } @ args:

let
  modules = [
    ./alacritty.nix
    ./home.nix
  ];
in
{
  imports = map (path: {
    home-manager.users.litarvan = import path args;
  }) modules;
}