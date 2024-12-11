{ inputs, lib, pkgsSets, root, ... }:

let
  flattenModules = modules:
    builtins.concatMap
      (value: if (builtins.typeOf value) == "set" then flattenModules value else [ value ])
      (builtins.attrValues modules);

  host = with lib.attrsets; system: path:
    let
      registry = (filterAttrs (name: _: name != "self") inputs) // { legion = inputs.self; };
      isDarwin = lib.strings.hasSuffix "-darwin" system;
    in
    (if isDarwin then inputs.nix-darwin.lib.darwinSystem else lib.nixosSystem) {
      inherit system;

      modules = [
        path

        (if isDarwin then inputs.home-manager.darwinModules.home-manager else inputs.home-manager.nixosModules.home-manager)
        (if isDarwin then inputs.nix-index-database.darwinModules.nix-index else inputs.nix-index-database.darwinModules.nix-index)

        (lib.legion.homeModules (flattenModules inputs.self.homeManagerModules))

        {
          nix = {
            nixPath = (mapAttrsToList (name: input: "${name}=${input}") inputs) ++ [ "nixos=${inputs.nixpkgs}" ];
            registry = mapAttrs (_: input: { flake = input; }) registry;
          };
          nixpkgs = {
            hostPlatform = system;
            pkgs = pkgsSets.pkgs.${system};
            overlays = attrValues inputs.self.overlays;
          };

          system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
        }
      ] ++ (flattenModules (if isDarwin then inputs.self.darwinModules else inputs.self.nixosModules));

      specialArgs = { inherit root lib isDarwin; } // (mapAttrs (_: set: set.${system}) pkgsSets);
    };
in
{
  # Home desktop | Aorus B550 PRO-P - Ryzen 5 3600X - AMD RX 6800 XT
  archimonde = host "x86_64-linux" ./archimonde;

  # Personal and work laptop | MacBook Pro 16" - M4 Pro
  sargeras = host "aarch64-darwin" ./sargeras;
}
