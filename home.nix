{
  config,
  pkgs,
  spicetify-nix,
  ...
}: {
  # Overlay some packages
  nixpkgs.overlays = [
    (self: super: {
      ffmpeg-full = super.ffmpeg-full.override {
        nonfreeLicensing = true;
        fdkaacExtlib = true;
      };
      mpv = super.mpv.override {
        scripts = [self.mpvScripts.thumbnail];
      };
      wezterm = super.wezterm.overrideAttrs (previousAttrs: rec {
        version = "a5c2b1f3adb06054bf522cb3d350697938d6f8e9";
        src = super.fetchFromGitHub {
          inherit (previousAttrs.src) owner repo fetchSubmodules;
          rev = version;
          sha256 = "05ndd6l0avs55rd82xwpir8v3zacz7i1j3an91rkn1q64jcvq0ld";
        };
        cargoDeps = previousAttrs.cargoDeps.overrideAttrs (super.lib.const {
          inherit src;
          name = "${previousAttrs.pname}-${version}-vendor.tar.gz";
          outputHash = "sha256-lP93bXJ7/NZN/vfUfYf/DTS/wtxoWJtPQp1Qu7nah8Q=";
        });
        postPatch = ''
          echo ${version} > .tag
          rm -r wezterm-ssh/tests
        '';
      });
      zls =
        (super.zls.override {
          zig = super.zig;
        })
        .overrideAttrs (previousAttrs: rec {
          version = "0.10.0";
          src = super.fetchFromGitHub {
            inherit (previousAttrs.src) owner repo fetchSubmodules;
            rev = version;
            sha256 = "1lsks7h3z2m4psyn9mwdylv1d6a9i3z54ssadiz76w0clbh8ch9k";
          };
        });
    })
  ];

  # Define the user
  users.users.paveloom = {
    name = "paveloom";
    description = "paveloom";
    home = "/home/paveloom";
    isNormalUser = true;
    extraGroups = [
      "keys"
      "networkmanager"
      "wheel"
    ];
    packages = pkgs.lib.lists.flatten (with pkgs; [
      adw-gtk3
      appimage-run
      asciinema
      audacious
      # authenticator
      baobab
      bat
      compsize
      dejavu_fonts
      discord
      element-desktop
      evince
      evolution
      exa
      fd
      ffmpeg_5-full
      firefox
      foliate
      # fractal-next
      fzf
      gimp
      glow
      gnome-console
      gnome-extension-manager
      gnome-icon-theme
      gnome-secrets
      google-chrome
      gparted
      icon-library
      imhex
      inkscape
      jackett
      julia
      lazygit
      libnotify
      libreoffice
      librewolf
      libva-utils
      metadata-cleaner
      monero-gui
      mousai
      mpv
      newsflash
      nicotine-plus
      nix-prefetch-scripts
      obs-studio
      picard
      qbittorrent
      quodlibet-full
      radeontop
      rclone
      ripgrep
      skypeforlinux
      sops
      taskwarrior
      tdesktop
      teams
      tenacity
      tor-browser-bundle-bin
      # radicle-cli
      rnote
      tracy
      tree
      ungoogled-chromium
      unzip
      wezterm
      wget
      wl-clipboard
      wxmaxima
      zip
      zoom-us
      zulip
      (with gnome; [
        cheese
        dconf-editor
        eog
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-clocks
        gnome-font-viewer
        gnome-system-monitor
        gnome-text-editor
        gnome-tweaks
        nautilus
        seahorse
        totem
      ])
      (with pkgs.gnomeExtensions; [
        clipboard-history
        dash-to-dock
        gesture-improvements
        hot-edge
        just-perfection
        media-controls
        memento-mori
        quick-settings-tweaker
        tray-icons-reloaded
      ])

      # Development
      (python311.withPackages (p: with p; [pip]))
      alejandra
      bun
      gcc
      git
      gnumake
      go
      icoutils
      jq
      ltex-ls
      meson
      neovim
      nil
      nixpkgs-fmt
      nixpkgs-hammering
      nixpkgs-review
      nodejs
      pkg-config
      podman
      podman-compose
      rustup
      shellcheck
      stylua
      sumneko-lua-language-server
      zig
      zls
    ]);
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
