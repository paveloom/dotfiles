{
  description = "@paveloom's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
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
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      commonModules = [
        ./configuration.nix
        ./home.nix
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
      ];

      nixosConfiguration = hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit pkgs;} // inputs;
          modules = commonModules ++ [hostModule];
        };
    in {
      devShells.default = pkgs.stdenv.mkDerivation {
        name = "dotfiles-shell";

        nativeBuildInputs = with pkgs; [
          alejandra
          ltex-ls
          lua-language-server
          nil
          nvd
          stylua
          yamlfmt
          yamllint
        ];
      };

      packages.nixosConfigurations = {
        boxes = nixosConfiguration ./hosts/boxes;
        laptop = nixosConfiguration ./hosts/laptop;
      };
    });
}
