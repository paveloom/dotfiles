{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations = let
      nixosHost = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules =
            [
              ./configuration.nix
              ./home.nix
              ./secrets.nix
              home-manager.nixosModules.home-manager
              nix-index-database.nixosModules.nix-index
              sops-nix.nixosModules.sops
            ]
            ++ host;
        };
    in {
      boxes = nixosHost [./hosts/boxes];
      laptop = nixosHost [./hosts/laptop];
    };
  };
}
