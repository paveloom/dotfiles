{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
  }: {
    nixosConfigurations = let
      nixosHost = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              ./configuration.nix
              ./home.nix
              ./secrets.nix
              home-manager.nixosModules.home-manager
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
