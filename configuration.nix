{
  config,
  nixpkgs,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
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
      gnome.epiphany
      gnome.geary
      gnome.gnome-contacts
      gnome.gnome-maps
      gnome.gnome-music
      gnome.gnome-shell-extensions
      gnome.gnome-software
      gnome.gnome-weather
    ];
    shells = [pkgs.fish];
    systemPackages = with pkgs; [
      gnome.nautilus-python
    ];
  };

  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.fonts;
      pathsToLink = ["/share/fonts"];
    };
  in {
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
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
    keyboard.zsa.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
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

  networking = {
    firewall = {
      allowedTCPPorts = [21044 38101 38102];
      allowedUDPPorts = [22174];
      checkReversePath = false;
    };
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    wireguard.enable = true;
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
    nixPath = ["nixpkgs=${nixpkgs}"];
    registry.nixpkgs = {
      flake = nixpkgs;
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
    gamemode.enable = true;
    git.enable = true;
    gnupg.agent.enable = true;
    nano.syntaxHighlight = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    steam.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  security.rtkit.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    btrfs.autoScrub.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
    };
    flatpak.enable = true;
    freshrss = {
      baseUrl = "http://localhost";
      database.type = "sqlite";
      enable = true;
      passwordFile = "/run/secrets/freshrss";
    };
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
    ipp-usb.enable = true;
    nginx.virtualHosts.freshrss.listen = [
      {
        addr = "0.0.0.0";
        port = 21044;
      }
    ];
    nixseparatedebuginfod.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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
      layout = "us,ru";
    };
  };

  sound.enable = true;

  system = {
    fsPackages = [pkgs.bindfs];
    stateVersion = "22.11";
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
        aegisub
        amdgpu_top
        anki
        apitrace
        appimage-run
        asciinema
        aspell
        aspellDicts.en
        aspellDicts.ru
        audacious
        authenticator
        bat
        bottles
        chatall
        compsize
        d-spy
        element-desktop
        enca
        exiftool
        fd
        (ffmpeg_6.override {
          withFdkAac = true;
          withUnfree = true;
          withWebp = true;
        })
        file
        firefox
        foliate
        fontforge-gtk
        fopnu
        # fractal-next
        fzf
        gamescope
        ghostscript
        gimp
        glow
        glxinfo
        gnome-extension-manager
        gnome-frog
        gnome-icon-theme
        gnome.dconf-editor
        gnome.gnome-sound-recorder
        gnome.gnome-tweaks
        gnome.gucharmap
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
        hunspell
        hunspellDicts.en_US
        hunspellDicts.ru_RU
        icon-library
        icoutils
        identity
        imagemagick
        img2pdf
        imhex
        inkscape
        inxi
        iw
        jq
        julia
        keepassxc
        lazygit
        libnotify
        libreoffice
        librewolf
        libva-utils
        linssid
        lshw
        lsof
        mangohud
        mecab
        mediainfo-gui
        metadata-cleaner
        microsoft-edge
        monero-gui
        mousai
        mpv
        neovim
        newsflash
        nicotine-plus
        nix-output-monitor
        nix-tree
        obs-studio
        ocrmypdf
        patchelf
        pciutils
        pdfarranger
        pdfgrep
        picard
        protonup-qt
        qbittorrent
        qolibri
        quodlibet-full
        radeontop
        radicle-cli
        rclone
        ripgrep
        rmg
        rnote
        ryujinx
        sqlite-interactive
        substudy
        subtitleedit
        taskwarrior
        tdesktop
        tenacity
        tor-browser-bundle-bin
        tracy
        tree
        unrar
        unzip
        upscayl
        virt-manager
        virtiofsd
        (vivaldi.override {
          enableWidevine = true;
          proprietaryCodecs = true;
        })
        (vlc.override {
          libbluray = libbluray.override {
            withJava = true;
          };
        })
        vocabsieve
        vscode
        vtfedit
        vulkan-tools
        wally-cli
        wezterm
        wget
        wirelesstools
        wl-clipboard
        xclip
        yandex-browser
        yt-dlp
        yuzu-early-access
        zeal
        zip
        zulip
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
