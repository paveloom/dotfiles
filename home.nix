{
  config,
  pkgs,
  ...
}: {
  # Define the user
  users.users.paveloom = {
    isNormalUser = true;
    description = "paveloom";
    extraGroups = ["networkmanager" "wheel"];
    packages = pkgs.lib.lists.flatten (
      with pkgs; [
        baobab
        evolution
        git
        gnome-extension-manager
        gnome-secrets
        gparted
        librewolf
        libva-utils
        nicotine-plus
        qbittorrent
        quodlibet
        radeontop
        tree
        wezterm
        wl-clipboard
        (with gnome; [
          cheese
          dconf-editor
          eog
          gnome-characters
          gnome-clocks
          gnome-font-viewer
          gnome-system-monitor
          gnome-text-editor
          gnome-tweaks
          nautilus
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
      ]
    );
  };

  # Setup home
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.paveloom = {
      # Setup Gnome
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = [
            "librewolf.desktop"
            "org.gnome.Nautilus.desktop"
            "gnome-system-monitor.desktop"
            "org.gnome.TextEditor.desktop"
            "org.wezfurlong.wezterm.desktop"
            "org.gnome.Evolution.desktop"
            "nicotine.desktop"
            "org.qbittorrent.qBittorrent.desktop"
            "io.github.quodlibet.QuodLibet.desktop"
            "org.gnome.World.Secrets.desktop"
          ];
        };
      };

      # Home manager version for the stateful data
      home.stateVersion = "22.11";
    };
  };
}
