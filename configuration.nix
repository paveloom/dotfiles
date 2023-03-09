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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable GPU acceleration
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

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

  # Configure keymap layouts
  services.xserver.layout = "us,ru";

  # Enable in-memory compression
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 50;

  # Enable udev rules for ZSA keyboards
  hardware.keyboard.zsa.enable = true;

  # Enable support for printers
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    canon-cups-ufr2
    carps-cups
    cnijfilter2
    cups-bjnp
    gutenprint
    gutenprintBin
  ];
  services.printing.logLevel = "debug";

  # Enable support for scanners
  hardware.sane.enable = true;
  hardware.sane.extraBackends = with pkgs; [
    sane-airscan
  ];
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
  services.ipp-usb.enable = true;

  # Set up Nix
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  nix.gc.automatic = true;
  nix.gc.dates = "14:00";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # NixOS version for the stateful data
  system.stateVersion = "22.11";
}
