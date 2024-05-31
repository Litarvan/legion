{ inputs, pkgsSets, ... }:

let
  inherit (inputs.nixpkgs) lib;

  flattenModules = modules:
    builtins.concatMap
      (value: if (builtins.typeOf value) == "set" then flattenModules value else [ value ])
      (builtins.attrValues modules);

  host = with lib.attrsets; system: path:
    let
      registry = (filterAttrs (name: _: name != "self") inputs) // { legion = inputs.self; };
    in
    lib.nixosSystem {
      inherit system;

      modules = [
        path

        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.nix-index

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
      ] ++ (flattenModules inputs.self.nixosModules);

      specialArgs = mapAttrs (_: set: set.${system}) pkgsSets;
    };
in
{
  # Home desktop | Aorus B550 PRO-P - Ryzen 5 3600X - AMD RX 6800 XT
  archimonde = host "x86_64-linux" ./archimonde;

  # Work laptop | Dell Inspiron 15 3520
  sargeras = host "x86_64-linux" ./sargeras;
}
