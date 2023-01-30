{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
  };
  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations = let
      nixosHost = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./configuration.nix] ++ host;
        };
    in {
      boxes = nixosHost [./hosts/boxes];
    };
  };
}
