{config, ...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      enable-hot-corners = false;
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
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
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
        "vivaldi-stable.desktop"
        "org.gnome.Evolution.desktop"
        "io.github.quodlibet.QuodLibet.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.TextEditor.desktop"
        "org.wezfurlong.wezterm.desktop"
        "io.gitlab.news_flash.NewsFlash.desktop"
        "org.qbittorrent.qBittorrent.desktop"
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
      extension-position = "Right";
      label-width = config.lib.gvariant.mkUint32 0;
      labels-order = ["ARTIST" "—" "TITLE"];
      mouse-action-left = "PLAY_PAUSE";
      mouse-action-right = "SHOW_POPUP_MENU";
      show-control-icons = false;
      show-player-icon = false;
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

  home.stateVersion = "24.05";

  xdg = {
    configFile = let
      configPath = dir: (config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Repositories/paveloom/dotfiles/.config/${dir}");
    in {
      "Code".source = configPath "Code";
      "MangoHud".source = configPath "MangoHud";
      "ccache".source = configPath "ccache";
      "direnv".source = configPath "direnv";
      "emacs".source = configPath "emacs";
      "fish".source = configPath "fish";
      "foot".source = configPath "foot";
      "gdb".source = configPath "gdb";
      "git".source = configPath "git";
      "helix".source = configPath "helix";
      "ideavim".source = configPath "ideavim";
      "lazydocker".source = configPath "lazydocker";
      "lazygit".source = configPath "lazygit";
      "mozc".source = configPath "mozc";
      "mpv".source = configPath "mpv";
      "nvim".source = configPath "nvim";
      "pdm".source = configPath "pdm";
      "sway".source = configPath "sway";
      "swaylock".source = configPath "swaylock";
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
