{
  config,
  pkgs,
  ...
}: {
  # Set up bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Roll the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Define users
  users.users.paveloom = {
    isNormalUser = true;
    description = "paveloom";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs.gnomeExtensions; [
      clipboard-history
      dash-to-dock
      gesture-improvements
      hot-edge
      just-perfection
      media-controls
      memento-mori
      quick-settings-tweaker
      tray-icons-reloaded
    ];
  };

  # Define packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = pkgs.lib.lists.flatten (
    with pkgs; [
      git
      gparted
      librewolf
      libva-utils
      qbittorrent
      radeontop
      tree
      wezterm
      wl-clipboard
      (with gnome; [
        baobab
        cheese
        dconf-editor
        eog
        gnome-characters
        gnome-clocks
        gnome-extension-manager
        gnome-font-viewer
        gnome-system-monitor
        gnome-text-editor
        gnome-tweaks
        nautilus
      ])
    ]
  );

  # Enable GPU acceleration
  hardware.opengl.enable = true;

  # Enable the GNOME Desktop Environment
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.gnome-shell-extensions
  ];
  services.gnome.core-utilities.enable = false;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable sound with Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Set up Nix
  nix.gc.automatic = true;
  nix.gc.dates = "14:00";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # NixOS version for the stateful data
  system.stateVersion = "22.11";
}
