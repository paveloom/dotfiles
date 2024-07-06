{
  description = "@paveloom's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";

    laptop.url = "path:./hosts/laptop";
    wsl.url = "path:./hosts/wsl";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
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
      laptop = inputs.laptop.nixosConfigurations.laptop;
      wsl = inputs.wsl.nixosConfigurations.wsl;
    };
  };
}
