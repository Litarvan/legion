{
  description = "Litarvan's desktops configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, nix-darwin, home-manager, flake-utils, ... } @ inputs:
    let
      lib = nixpkgs.lib // { legion = import ./lib; };

      makePackageSet = pkgsInput: builtins.listToAttrs (map
        (system: {
          name = system;
          value = import pkgsInput {
            inherit system;

            overlays = builtins.attrValues self.overlays;
            config.allowUnfree = true;
          };
        })
        flake-utils.lib.defaultSystems);
      pkgsSets = lib.mapAttrs (_: input: makePackageSet input) {
        pkgs = nixpkgs;
        pkgsUnstable = nixpkgsUnstable;
      };

      systems = import ./systems {
        inherit inputs lib pkgsSets;
        root = ./.;
      };
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = pkgsSets.pkgs.${system};
      in
      {
        # System-specific outputs

        packages = import ./pkgs { inherit lib pkgs; };
      }
    )) // {
      # Non-system-specific outputs

      lib = lib.legion;

      overlays = import ./pkgs/overlays.nix { inherit lib; };

      nixosModules = import ./modules/nixos;
      nixosConfigurations = lib.attrsets.filterAttrs (name: system: !system._module.specialArgs.isDarwin) systems; # A bit sus

      darwinModules = import ./modules/darwin;
      darwinConfigurations = lib.attrsets.filterAttrs (name: system: system._module.specialArgs.isDarwin) systems;

      homeManagerModules = import ./modules/home;
      # TODO: Home configurations

      # Allows to rebuild the config with the same version of nix-darwin exposed by the flake
      # Using the already installed `darwin-rebuild` command will build the config with the previous version of the modules (not just the CLI)
      packages.aarch64-darwin.darwin-rebuild = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
    };
}
