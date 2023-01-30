{
  config,
  pkgs,
  ...
}: {
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

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
  };

  # Define packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    gparted
    librewolf
    libva-utils
    qbittorrent
    radeontop
    tree
    wl-clipboard
  ];
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      gnome-music
      epiphany
      geary
      totem
    ]);

  # Enable GPU acceleration
  hardware.opengl.enable = true;

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable SPICE integration for a QEMU guest system
  services.spice-vdagentd.enable = true;

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

  # NixOS version for the stateful data
  system.stateVersion = "22.11";
}
