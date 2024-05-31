{
  description = "Litarvan's desktops configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, flake-utils, home-manager, ... } @ inputs:
    let
      inherit (nixpkgs) lib;

      makePackageSet = pkgsInput: builtins.listToAttrs (map (system: {
        name = system;
        value = import pkgsInput {
          inherit system;

          overlays = builtins.attrValues self.overlays;
          config.allowUnfree = true;
        };
      }) flake-utils.lib.defaultSystems);
      pkgsSets = lib.mapAttrs (_: input: makePackageSet input) {
        pkgs = nixpkgs;
        pkgsUnstable = nixpkgsUnstable;
      };
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = pkgsSets.pkgs.${system};
      in
      {
        packages = import ./pkgs { inherit lib pkgs; };
      }
    )) // {
      overlays = import ./pkgs/overlays.nix { inherit lib; };

      nixosModules = import ./modules;
      nixosConfigurations = import ./systems { inherit inputs pkgsSets; };
    };
}
