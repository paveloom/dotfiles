{
  pkgs,
  config,
  ...
}: {
  environment.shells = [pkgs.fish];

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.paveloom = {
      config,
      lib,
      pkgs,
      ...
    }: {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          clock-show-weekday = true;
          enable-hot-corners = false;
          gtk-theme = "adw-gtk3";
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = [];
          switch-applications-backward = [];
          switch-windows = ["<Alt>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab"];
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/nautilus/preferences" = {
          click-policy = "single";
          show-create-link = true;
          show-delete-permanently = true;
        };
        "org/gnome/desktop/notifications/application/org-gnome-evolution" = {
          enable-sound-alerts = false;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          disable-while-typing = false;
          tap-to-click = true;
        };
        "org/gnome/desktop/session" = {
          idle-delay = config.lib.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/sound" = {
          theme-name = "default";
        };
        "org/gnome/desktop/input-sources" = {
          show-all-sources = true;
          sources = [
            (config.lib.gvariant.mkTuple
              ["xkb" "us"])
            (config.lib.gvariant.mkTuple
              ["xkb" "ru"])
          ];
        };
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-schedule-automatic = false;
          night-light-schedule-from = 20;
          night-light-temperature = config.lib.gvariant.mkUint32 4375;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          idle-dim = false;
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-type = "nothing";
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "clipboard-history@alexsaveau.dev"
            "dash-to-dock@micxgx.gmail.com"
            "gestureImprovements@gestures"
            "just-perfection-desktop@just-perfection"
            "mediacontrols@cliffniff.github.com"
            "memento-mori@paveloom"
            "trayIconsReloaded@selfmade.pl"
          ];
          favorite-apps = [
            "librewolf.desktop"
            "org.gnome.Nautilus.desktop"
            "gnome-system-monitor.desktop"
            "org.gnome.TextEditor.desktop"
            "org.wezfurlong.wezterm.desktop"
            "org.gnome.Evolution.desktop"
            "com.gitlab.newsflash.desktop"
            "org.nicotine_plus.Nicotine.desktop"
            "org.qbittorrent.qBittorrent.desktop"
            "io.github.quodlibet.QuodLibet.desktop"
            "org.keepassxc.KeePassXC.desktop"
            "com.lakoliu.Furtherance.desktop"
          ];
        };
        "org/gnome/shell/extensions/clipboard-history" = {
          history-size = 100;
          next-entry = ["<Control><Alt>n"];
          paste-on-selection = false;
          prev-entry = ["<Control><Alt>b"];
          window-width-percentage = 24;
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
          click-action = "focus-minimize-or-previews";
          dash-max-icon-size = 56;
          disable-overview-on-startup = true;
          dock-fixed = false;
          intellihide = false;
          isolate-workspaces = true;
          pressure-threshold = 0.0;
          running-indicator-style = "DOTS";
          scroll-action = "switch-workspace";
          show-mounts = false;
          show-trash = false;
          transparency-mode = "DYNAMIC";
        };
        "org/gnome/shell/extensions/gestureImprovements" = {
          default-overview-gesture-direction = false;
          touchpad-speed-scale = 1.5;
        };
        "org/gnome/shell/extensions/hotedge" = {
          pressure-threshold = 25;
        };
        "org/gnome/shell/extensions/just-perfection" = {
          window-demands-attention-focus = true;
          workspace-popup = false;
          workspace-wrap-around = true;
        };
        "org/gnome/shell/extensions/mediacontrols" = {
          extension-position = "right";
          max-widget-width = 350;
          show-control-icons = false;
          show-player-icon = false;
          show-seperators = false;
          show-sources-menu = false;
          backlist-apps = [
            "librewolf"
          ];
          mouse-actions = [
            "toggle_play"
            "toggle_menu"
            "toggle_info"
            "none"
            "none"
            "none"
            "none"
            "none"
          ];
          track-label = [
            "artist"
            "—"
            "track"
          ];
        };
        "org/gnome/shell/extensions/memento-mori" = {
          birth-day = 9;
          birth-month = 7;
          birth-year = 1999;
          extension-index = 1;
          extension-position = "Center";
          life-expectancy = 80;
        };
      };

      home.stateVersion = "22.11";

      systemd.user = {
        services = {
          flatpak-update = {
            Unit.Description = "Update Flatpak packages";
            Service.ExecStart =
              (pkgs.writeShellScript "update-flatpak" ''
                ${pkgs.flatpak}/bin/flatpak update --noninteractive
                ${pkgs.flatpak}/bin/flatpak uninstall --unused --noninteractive
              '')
              .outPath;
          };
        };
        timers = {
          flatpak-update = {
            Unit = {
              Description = "Update all Flatpak packages on a schedule";
            };
            Timer = {
              OnCalendar = ["14:00"];
              Persistent = true;
            };
            Install.WantedBy = ["timers.target"];
          };
        };
      };

      xdg = {
        configFile = let
          configPath = dir: (config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/Repositories/paveloom/dotfiles/.config/${dir}");
        in {
          "MangoHud".source = configPath "MangoHud";
          "ccache".source = configPath "ccache";
          "direnv".source = configPath "direnv";
          "fish".source = configPath "fish";
          "git".source = configPath "git";
          "helix".source = configPath "helix";
          "lazygit".source = configPath "lazygit";
          "mpv".source = configPath "mpv";
          "nvim".source = configPath "nvim";
          "pdm".source = configPath "pdm";
          "task".source = configPath "task";
          "wezterm".source = configPath "wezterm";
          "yamlfmt".source = configPath "yamlfmt";
          "yamllint".source = configPath "yamllint";
        };
        userDirs = {
          createDirectories = true;
          enable = true;
        };
      };
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

  services = {
    flatpak.enable = true;
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
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };

  system.fsPackages = [pkgs.bindfs];

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
}
