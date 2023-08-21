{
  description = "@paveloom's NixOS configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs = {
    flake-utils,
    home-manager,
    nix-index-database,
    nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      commonModules = [
        ./configuration.nix
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
          libxml2
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
