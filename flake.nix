{
  inputs = {
    nixpkgs.url = "github:paveloom/nixpkgs/system";
  };

  outputs = {nixpkgs, ...}: let
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
  };
}
