{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.shells = [pkgs.fish];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa.drivers
    ];
  };

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
    nginx = {
      appendHttpConfig = ''
        include /etc/nginx/sites-enabled/*.conf;
      '';
      enable = true;
      user = "paveloom";
    };
    vscode-server.enable = true;
  };

  system = {
    stateVersion = "23.11";
  };

  systemd.services.nginx.serviceConfig.ProtectHome = false;

  time.timeZone = "Europe/Moscow";

  users.users.paveloom = {
    home = "/home/paveloom";
    packages = with pkgs; [
      bat
      btop
      dnsutils
      dua
      fd
      (ffmpeg_7.override {
        withFdkAac = true;
        withUnfree = true;
        withWebp = true;
      })
      inetutils
      jetbrains.phpstorm
      jetbrains.pycharm-professional
      jetbrains.webstorm
      julia
      lazygit
      lego
      lftp
      lsof
      neovim
      nix-output-monitor
      nix-tree
      nvd
      openssl
      ripgrep
      speedtest-cli
      streamrip
      swaks
      tree
      unzip
      wget
      wl-clipboard
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
    useWindowsDriver = true;
  };
}
