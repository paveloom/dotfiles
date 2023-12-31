{
  config,
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
        (config.lib.gvariant.mkTuple ["xkb" "us"])
        (config.lib.gvariant.mkTuple ["xkb" "ru"])
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
        "Vitals@CoreCoding.com"
      ];
      favorite-apps = [
        "google-chrome.desktop"
        "org.gnome.Nautilus.desktop"
        "gnome-system-monitor.desktop"
        "org.gnome.TextEditor.desktop"
        "org.wezfurlong.wezterm.desktop"
        "code.desktop"
        "io.gitlab.news_flash.NewsFlash.desktop"
        "org.nicotine_plus.Nicotine.desktop"
        "org.qbittorrent.qBittorrent.desktop"
        "io.github.quodlibet.QuodLibet.desktop"
        "org.keepassxc.KeePassXC.desktop"
        "gnucash.desktop"
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
      scroll-track-label = true;
      show-control-icons = false;
      show-player-icon = false;
      show-seperators = false;
      show-sources-menu = false;
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
      extension-position = "center";
      life-expectancy = 80;
    };
    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = false;
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "_network-rx_wlo1_rx_"
        "_network-tx_wlo1_tx_"
        "_storage_free_"
      ];
      network-speed-format = 1;
      position-in-panel = 0;
      update-time = 1;
      use-higher-precision = true;
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
      "Code".source = configPath "Code";
      "MangoHud".source = configPath "MangoHud";
      "ccache".source = configPath "ccache";
      "direnv".source = configPath "direnv";
      "fish".source = configPath "fish";
      "gdb".source = configPath "gdb";
      "git".source = configPath "git";
      "helix".source = configPath "helix";
      "lazygit".source = configPath "lazygit";
      "mozc".source = configPath "mozc";
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
}
