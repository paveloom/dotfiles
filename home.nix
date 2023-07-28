{
  pkgs,
  config,
  ...
}: {
  # Help when a command is not found
  programs.command-not-found.enable = false;
  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;

  # Enable `fzf` features
  programs.fzf.fuzzyCompletion = true;
  programs.fzf.keybindings = true;

  # Use Fish as the default system shell
  environment.shells = [pkgs.fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Set up Git
  programs.git.enable = true;

  # Set up GnuPG agent
  programs.gnupg.agent.enable = true;

  # Set up Evince
  programs.evince.enable = true;

  # Set up Evolution
  programs.evolution.enable = true;

  # Set up network
  networking.firewall.checkReversePath = false;
  networking.firewall = {
    allowedTCPPorts = [
      38101
      38102
    ];
  };
  networking.networkmanager.enable = true;

  # Set up iOS support
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # Set up Wireguard
  networking.wireguard.enable = true;

  # Set up *Arrs
  services.prowlarr.enable = true;
  services.radarr = {
    dataDir = "/home/paveloom/.config/radarr";
    enable = true;
    group = "";
    user = "paveloom";
  };
  services.sonarr = {
    dataDir = "/home/paveloom/.config/sonarr";
    enable = true;
    group = "";
    user = "paveloom";
  };
  services.whisparr = {
    dataDir = "/home/paveloom/.config/whisparr";
    enable = true;
    group = "";
    user = "paveloom";
  };

  # Set up Gamemode
  programs.gamemode.enable = true;

  # Set up Podman
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    dockerCompat = true;
  };

  # Set up the `libvirtd` daemon
  virtualisation.libvirtd.enable = true;

  # Set up Flatpak
  services.flatpak.enable = true;
  system.fsPackages = [pkgs.bindfs];
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
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };

  # Define the user
  users.users.paveloom = {
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
      dejavu_fonts
      element-desktop
      exa
      exiftool
      fd
      (ffmpeg_6.override {
        withUnfree = true;
        withFdkAac = true;
      })
      firefox
      foliate
      fractal-next
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
      gparted
      hunspell
      hunspellDicts.ru_RU
      icon-library
      identity
      imagemagick
      img2pdf
      imhex
      inkscape
      keepassxc
      lazygit
      libnotify
      libreoffice
      librewolf
      libva-utils
      mediainfo-gui
      metadata-cleaner
      monero-gui
      mousai
      (mpv.override {
        scripts = [mpvScripts.thumbnail];
      })
      newsflash
      nicotine-plus
      obs-studio
      ocrmypdf
      pdfarranger
      pdfgrep
      picard
      protonup-qt
      qbittorrent
      quodlibet-full
      radeontop
      rclone
      ripgrep
      simple-scan
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
      wl-clipboard
      yt-dlp
      zip
      zulip

      # Time tracking
      furtherance

      # Wireless tools
      iw
      linssid
      wirelesstools

      # Development
      direnv
      file
      icoutils
      jq
      julia
      neovim
      nix-direnv
      radicle-cli
      sqlite-interactive
      zeal
    ];
  };

  # Setup home
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.paveloom = {
      config,
      lib,
      pkgs,
      ...
    }: {
      # Set up Flatpak updates
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

      # Enable fontconfig configuration
      fonts.fontconfig.enable = true;

      # Set up configs
      xdg.configFile = let
        configPath = dir: (config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/Repositories/paveloom/dotfiles/.config/${dir}");
      in {
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

      # Setup Gnome
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

      # Home manager version for the stateful data
      home.stateVersion = "22.11";
    };
  };
}
