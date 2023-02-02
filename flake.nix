{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations = let
      nixosHost = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              ./configuration.nix
              ./home.nix
              home-manager.nixosModules.home-manager
            ]
            ++ host;
        };
    in {
      boxes = nixosHost [./hosts/boxes];
      laptop = nixosHost [./hosts/laptop];
    };
  };
}
