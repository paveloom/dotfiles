{
  inputs,
  pkgs,
  ...
}: {
  environment.shells = [pkgs.fish];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.paveloom = import ./home.nix;
  };

  imports = with inputs; [
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index
    nixoswsl.nixosModules.wsl
    vscode-server.nixosModules.default
  ];

  programs = {
    command-not-found.enable = false;
    direnv.enable = true;
    fish.enable = true;
    git.enable = true;
    gnupg.agent.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-ld.enable = true;
    ssh.startAgent = true;
  };

  services = {
    vscode-server.enable = true;
  };

  system = {
    stateVersion = "23.11";
  };

  users.users.paveloom = {
    home = "/home/paveloom";
    packages = with pkgs; [
      lazygit
      wget
    ];
    shell = pkgs.fish;
  };

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };

  wsl = {
    defaultUser = "paveloom";
    enable = true;
    extraBin = with pkgs; [
      {src = "${coreutils}/bin/uname";}
      {src = "${coreutils}/bin/dirname";}
      {src = "${coreutils}/bin/readlink";}
    ];
  };
}
