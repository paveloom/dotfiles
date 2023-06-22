{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    flake-utils,
    home-manager,
    nix-index-database,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.nixosConfigurations = let
        global = {
          nixpkgs = {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
        nixosHost = host:
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = inputs;
            modules =
              [
                ./configuration.nix
                ./home.nix
                global
                home-manager.nixosModules.home-manager
                nix-index-database.nixosModules.nix-index
              ]
              ++ host;
          };
      in {
        boxes = nixosHost [./hosts/boxes];
        laptop = nixosHost [./hosts/laptop];
      };
    });
}
