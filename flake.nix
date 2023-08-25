{
  description = "@paveloom's NixOS configuration";

  inputs = {
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
    home-manager,
    nix-index-database,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    commonModules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      nix-index-database.nixosModules.nix-index
    ];

    nixosConfiguration = hostModule:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = inputs;
        modules = commonModules ++ [hostModule];
      };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "dotfiles-shell";

      packages = with pkgs; [
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

    nixosConfigurations = {
      boxes = nixosConfiguration ./hosts/boxes;
      laptop = nixosConfiguration ./hosts/laptop;
    };
  };
}
