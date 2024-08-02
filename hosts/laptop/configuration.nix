{
  config,
  inputs,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = true;
    };
    tmp = {
      useTmpfs = true;
    };
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-photos
      gnome-tour
      gnome.gnome-contacts
      gnome.gnome-maps
      gnome.gnome-music
      gnome.gnome-shell-extensions
      gnome.gnome-software
      gnome.gnome-weather
    ];
    shells = [pkgs.fish];
    systemPackages = with pkgs; [
      nautilus-python
    ];
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      corefonts
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    keyboard.zsa.enable = true;
    pulseaudio.enable = false;
    sane = {
      enable = true;
      extraBackends = with pkgs; [
        sane-airscan
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.paveloom = import ./home.nix;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  imports = with inputs; [
    home-manager.nixosModules.home-manager
    nix-index-database.nixosModules.nix-index
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [8081 8082 9000 21044 38101 38102];
      allowedUDPPorts = [22174];
      checkReversePath = false;
    };
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

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
    evolution.enable = true;
    fish.enable = true;
    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };
    gamemode.enable = true;
    geary.enable = false;
    git.enable = true;
    gnupg.agent.enable = true;
    nano.syntaxHighlight = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-ld.enable = true;
    steam.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  security.rtkit.enable = true;

  services = {
    flaresolverr.enable = true;
    freshrss = {
      baseUrl = "http://localhost";
      database.type = "sqlite";
      enable = true;
      passwordFile = "/run/secrets/freshrss";
    };
    ipp-usb.enable = true;
    logind.lidSwitch = "ignore";
    nginx = {
      appendHttpConfig = ''
        include /etc/nginx/sites-enabled/*.conf;
      '';
      virtualHosts.freshrss.listen = [
        {
          addr = "0.0.0.0";
          port = 21044;
        }
      ];
    };
    nixseparatedebuginfod.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig = let
        rate = 48000;
        quantum = 32;
        req = "${toString quantum}/${toString rate}";
      in {
        pipewire."92-low-latency" = {
          context.properties = {
            default.clock.rate = rate;
            default.clock.quantum = quantum;
            default.clock.min-quantum = quantum;
            default.clock.max-quantum = quantum;
          };
        };
        pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = req;
                pulse.default.req = req;
                pulse.max.req = req;
                pulse.min.quantum = req;
                pulse.max.quantum = req;
              };
            }
          ];
          stream.properties = {
            node.latency = req;
            resample.quality = 1;
          };
        };
      };
    };
    printing = {
      drivers = with pkgs; [
        canon-cups-ufr2
        carps-cups
        cnijfilter2
        cups-bjnp
        gutenprint
        gutenprintBin
      ];
      enable = true;
      logLevel = "debug";
    };
    prowlarr.enable = true;
    radarr = {
      dataDir = config.users.users.paveloom.home + "/.config/radarr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    samba = {
      enable = true;
      openFirewall = true;
      shares = {
        public = {
          path = "%H/Public/Samba";
          "vfs objects" = "fruit streams_xattr";
          writeable = "yes";
        };
      };
    };
    sonarr = {
      dataDir = config.users.users.paveloom.home + "/.config/sonarr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    whisparr = {
      dataDir = config.users.users.paveloom.home + "/.config/whisparr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {layout = "us,ru";};
    };
  };

  system = {
    fsPackages = [pkgs.bindfs];
    stateVersion = "24.05";
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  time.timeZone = "Europe/Moscow";

  users = {
    users.paveloom = {
      createHome = true;
      extraGroups = [
        "keys"
        "libvirtd"
        "lp"
        "networkmanager"
        "scanner"
        "wheel"
        "wireshark"
      ];
      home = "/home/paveloom";
      isNormalUser = true;
      name = "paveloom";
      packages = with pkgs; [
        acpi
        amdgpu_top
        appimage-run
        asciinema
        aspell
        aspellDicts.en
        aspellDicts.ru
        audacious
        authenticator
        bat
        bottles
        d-spy
        dconf-editor
        dua
        fd
        (ffmpeg_7.override {
          withFdkAac = true;
          withUnfree = true;
          withWebp = true;
        })
        file
        firefox
        foliate
        fontforge-gtk
        fopnu
        fzf
        gamescope
        gimp
        gnome-extension-manager
        gnome-frog
        gnome-icon-theme
        gnome-tweaks
        gnome.gnome-sound-recorder
        gnomeExtensions.appindicator
        gnomeExtensions.clipboard-history
        gnomeExtensions.dash-to-dock
        gnomeExtensions.gesture-improvements
        gnomeExtensions.hot-edge
        gnomeExtensions.just-perfection
        gnomeExtensions.media-controls
        gnomeExtensions.memento-mori
        gnomeExtensions.vitals
        gnucash
        google-chrome
        goverlay
        gparted
        gucharmap
        hunspell
        hunspellDicts.en_US
        hunspellDicts.ru_RU
        inkscape
        jetbrains.phpstorm
        jetbrains.pycharm-professional
        jetbrains.webstorm
        # julia
        keepassxc
        lazygit
        libnotify
        libreoffice
        libva-utils
        mangohud
        monero-gui
        mpv
        neovim
        newsflash
        nix-tree
        obs-studio
        patchelf
        picard
        protonup-qt
        qbittorrent
        quodlibet-full
        (retroarch.override {
          cores = with libretro; [
            mesen
          ];
        })
        ripgrep
        streamrip
        subtitleedit
        tdesktop
        tree
        unrar
        unzip
        virt-manager
        virtiofsd
        (vivaldi.override {
          enableWidevine = true;
          proprietaryCodecs = true;
        })
        vscode
        wally-cli
        wezterm
        wget
        wl-clipboard
        xclip
        zip
      ];
      shell = pkgs.fish;
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };

  zramSwap = {
    algorithm = "zstd";
    enable = true;
    memoryPercent = 50;
  };
}
