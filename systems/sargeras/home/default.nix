{ ... } @ args:

let
  modules = [
    ./home.nix

    ./alacritty.nix
    ./i3.nix
    ./picom.nix
  ];
in
{
  imports = map (path: {
    home-manager.users.litarvan = import path args;
  }) modules;
}
