{
  config,
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

  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "14:00";
      options = "--delete-older-than 7d";
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    registry.nixpkgs = {
      flake = inputs.nixpkgs;
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    command-not-found.enable = false;
    direnv.enable = true;
    fish.enable = true;
    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };
    git.enable = true;
    gnupg.agent.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-ld.enable = true;
  };

  services = {
    gitea-actions-runner = {
      package = pkgs.forgejo-actions-runner;
      instances = {
        nixos = {
          enable = true;
          labels = ["ubuntu-latest:docker://node:18-bullseye"];
          name = "NixOS";
          settings = {
            container = {
              network = "host";
            };
          };
          tokenFile = config.users.users.paveloom.home + "/.config/forgejo-runner/nixos.env";
          url = "https://codeberg.org";
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    vscode-server.enable = true;
  };

  system = {
    stateVersion = "23.11";
  };

  users.users.paveloom = {
    home = "/home/paveloom";
    packages = with pkgs; [
      bat
      dnsutils
      fd
      (ffmpeg_6.override {
        withFdkAac = true;
        withUnfree = true;
        withWebp = true;
      })
      inetutils
      julia
      lazygit
      lftp
      lsof
      nvd
      openssl
      ripgrep
      speedtest-cli
      streamrip
      swaks
      tree
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
