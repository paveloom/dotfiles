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
    nixseparatedebuginfod = {
      url = "github:symphorien/nixseparatedebuginfod";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    home-manager,
    nix-index-database,
    nixpkgs,
    nixseparatedebuginfod,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    nixosConfiguration = hostModule:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {inherit inputs;};
        modules = [hostModule];
      };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "dotfiles-shell";

      packages = with pkgs; [
        alejandra
        bashInteractive
        libxml2
        lua-language-server
        nil
        nvd
        stylua
      ];
    };

    nixosConfigurations = {
      boxes = nixosConfiguration ./hosts/boxes;
      nixos = nixosConfiguration ./hosts/nixos;
    };
  };
}
