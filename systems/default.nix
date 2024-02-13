{ inputs, pkgsSets, ... }:

let
  inherit (inputs.nixpkgs) lib;

  host = with lib.attrsets; system: path:
    let
      registry = (filterAttrs (name: _: name != "self") inputs) // { legion = inputs.self; };
    in
    lib.nixosSystem {
      inherit system;

      modules = [
        path
        inputs.home-manager.nixosModules.home-manager
        {
          nix = {
            nixPath = (mapAttrsToList (name: input: "${name}=${input}") inputs) ++ [ "nixos=${inputs.nixpkgs}" ];
            registry = mapAttrs (_: input: { flake = input; }) registry;
          };
          nixpkgs = {
            pkgs = pkgsSets.pkgs.${system};
            overlays = attrValues inputs.self.overlays;
          };
        }
      ] ++ (attrValues inputs.self.nixosModules);

      specialArgs = mapAttrs (_: set: set.${system}) pkgsSets;
    };
in
{
  sargeras = host "x86_64-linux" ./sargeras;
}
