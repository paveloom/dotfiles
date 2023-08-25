{
  config,
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
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome.gnome-shell-extensions
    ];
    shells = [pkgs.fish];
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
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [mozc];
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [38101 38102];
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
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    command-not-found.enable = false;
    evince.enable = true;
    evolution.enable = true;
    fish.enable = true;
    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };
    gamemode.enable = true;
    git.enable = true;
    gnupg.agent.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  security.rtkit.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    flatpak.enable = true;
    gnome.core-utilities.enable = false;
    ipp-usb.enable = true;
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
      dataDir = "/home/paveloom/.config/radarr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    sonarr = {
      dataDir = "/home/paveloom/.config/sonarr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    whisparr = {
      dataDir = "/home/paveloom/.config/whisparr";
      enable = true;
      group = "";
      user = "paveloom";
    };
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
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

  time.timeZone = "Europe/Moscow";

  users = {
    defaultUserShell = pkgs.fish;
    users.paveloom = {
      name = "paveloom";
      description = "paveloom";
      home = "/home/paveloom";
      isNormalUser = true;
      extraGroups = [
        "keys"
        "libvirtd"
        "lp"
        "networkmanager"
        "scanner"
        "wheel"
        "wireshark"
      ];
      packages = with pkgs; [
        acpi
        adw-gtk3
        aegisub
        appimage-run
        asciinema
        aspell
        aspellDicts.en
        aspellDicts.ru
        audacious
        authenticator
        baobab
        bat
        bottles
        compsize
        direnv
        element-desktop
        exa
        exiftool
        fd
        (ffmpeg_6.override {
          withUnfree = true;
          withFdkAac = true;
        })
        file
        firefox
        foliate
        fractal-next
        furtherance
        fzf
        ghostscript
        gimp
        glow
        gnome-console
        gnome-extension-manager
        gnome-frog
        gnome-icon-theme
        gnome-text-editor
        gnome.cheese
        gnome.dconf-editor
        gnome.eog
        gnome.gnome-calculator
        gnome.gnome-calendar
        gnome.gnome-characters
        gnome.gnome-clocks
        gnome.gnome-disk-utility
        gnome.gnome-font-viewer
        gnome.gnome-sound-recorder
        gnome.gnome-system-monitor
        gnome.gnome-tweaks
        gnome.nautilus
        gnome.seahorse
        gnome.totem
        gnomeExtensions.appindicator
        gnomeExtensions.clipboard-history
        gnomeExtensions.dash-to-dock
        gnomeExtensions.gesture-improvements
        gnomeExtensions.hot-edge
        gnomeExtensions.just-perfection
        gnomeExtensions.media-controls
        gnomeExtensions.memento-mori
        goverlay
        gparted
        hunspell
        hunspellDicts.ru_RU
        icon-library
        icoutils
        identity
        imagemagick
        img2pdf
        imhex
        inkscape
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
        mangohud
        mediainfo-gui
        metadata-cleaner
        monero-gui
        mousai
        mpv
        neovim
        newsflash
        nicotine-plus
        (nix-direnv.overrideAttrs (old: {
          version = "unstable-2023-07-27";
          src = fetchFromGitHub {
            owner = "nix-community";
            repo = "nix-direnv";
            rev = "ed2cb75553b4864e3c931a48e3a2cd43b93152c5";
            hash = "sha256-jCpEcbdgC1CnCFOXIUnNGgCTMCIHLnMR3oeFLf4FQLo=";
          };
        }))
        nix-output-monitor
        nix-tree
        obs-studio
        ocrmypdf
        pdfarranger
        pdfgrep
        picard
        protonup-qt
        qbittorrent
        quodlibet-full
        radeontop
        radicle-cli
        rclone
        ripgrep
        simple-scan
        sqlite-interactive
        subtitleedit
        taskwarrior
        tdesktop
        tenacity
        tor-browser-bundle-bin
        tracy
        tree
        unrar
        unzip
        virt-manager
        virtiofsd
        (vlc.override {
          libbluray = libbluray.override {
            withJava = true;
          };
        })
        wally-cli
        webtorrent_desktop
        wezterm
        wget
        wirelesstools
        wl-clipboard
        yt-dlp
        zeal
        zip
        zulip
      ];
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
