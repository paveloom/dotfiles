{
  pkgs,
  spicetify-nix,
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

  # Set up Evince
  programs.evince.enable = true;

  # Set up Mullvad VPN
  networking.firewall.interfaces.wg-mullvad.allowedTCPPorts = [
    55853
    57236
  ];
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

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

  # Set up Steam
  programs.steam.enable = true;

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
      compsize
      dejavu_fonts
      discord
      element-desktop
      evolution
      exa
      fd
      (ffmpeg_6.override {
        withUnfree = true;
        withFdkAac = true;
      })
      firefox
      foliate
      fractal-next
      fzf
      gimp
      glow
      gnome-console
      gnome-extension-manager
      gnome-frog
      gnome-icon-theme
      gnome-secrets
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
      gnome.gnome-system-monitor
      gnome.gnome-tweaks
      gnome.nautilus
      gnome.seahorse
      gnome.totem
      gnomeExtensions.clipboard-history
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gesture-improvements
      gnomeExtensions.hot-edge
      gnomeExtensions.just-perfection
      gnomeExtensions.media-controls
      gnomeExtensions.memento-mori
      gnomeExtensions.quick-settings-tweaker
      gnomeExtensions.tray-icons-reloaded
      gnupg
      google-chrome
      gparted
      hunspell
      hunspellDicts.ru_RU
      icon-library
      identity
      imagemagick
      img2pdf
      imhex
      inkscape
      jackett
      julia
      lazygit
      libnotify
      libreoffice
      librewolf
      libva-utils
      lutris
      mediainfo
      metadata-cleaner
      monero-gui
      mousai
      (mpv.override {
        scripts = [mpvScripts.thumbnail];
      })
      newsflash
      nicotine-plus
      nix-prefetch-scripts
      obs-studio
      ocrmypdf
      okular
      openai-whisper-cpp
      pdfgrep
      picard
      protonup-qt
      qbittorrent
      quodlibet-full
      radeontop
      radicle-cli
      rclone
      ripgrep
      rnote
      simple-scan
      skypeforlinux
      subtitleedit
      taskwarrior
      tdesktop
      teams
      tenacity
      tor-browser-bundle-bin
      tracy
      tree
      ungoogled-chromium
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
      wxmaxima
      yt-dlp
      zip
      zoom-us
      zulip

      # Development
      alejandra
      bun
      direnv
      dive
      file
      gcc
      git
      gnumake
      go
      helix
      icoutils
      jq
      ltex-ls
      lua-language-server
      meson
      neovim
      nil
      nix-direnv
      nixpkgs-fmt
      nixpkgs-hammering
      nixpkgs-review
      nodePackages.npm-check-updates
      nodejs
      pkg-config
      podman-compose
      rpm
      runc
      rust-analyzer
      rustup
      skopeo
      stylua
      tmux
      umoci
      valgrind
      yamlfmt
      yamllint
      zig
      # zigmod
      zls
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
    }: let
      spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
    in {
      # Import home manager modules
      imports = [spicetify-nix.homeManagerModules.default];

      # Set up Spicetify
      programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.Default;
        colorScheme = "default";
        enabledExtensions = with spicePkgs.extensions; [
          adblock
        ];
      };

      # Enable fontconfig configuration
      fonts.fontconfig.enable = true;

      # Set up configs
      xdg.configFile = let
        configPath = dir: (config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/Repositories/paveloom/dotfiles/.config/${dir}");
      in {
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
            "clipboard-history@alexsaveau.dev"
            "dash-to-dock@micxgx.gmail.com"
            "gestureImprovements@gestures"
            "just-perfection-desktop@just-perfection"
            "mediacontrols@cliffniff.github.com"
            "memento-mori@paveloom"
            "quick-settings-tweaks@qwreey"
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
            "org.gnome.World.Secrets.desktop"
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
          notification-banner-position = 2;
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
        "org/gnome/shell/extensions/quick-settings-tweaks" = {
          media-control-enabled = false;
          volume-mixer-enabled = false;
        };
        "org/gnome/shell/extensions/trayIconsReloaded" = {
          icon-padding-horizontal = 6;
        };
      };

      # Home manager version for the stateful data
      home.stateVersion = "22.11";
    };
  };
}
