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

  # Configure keymap layouts
  services.xserver.layout = "us,ru";

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

  # Set up Mullvad VPN
  networking.firewall.interfaces.wg-mullvad.allowedTCPPorts = [
    55853
    57236
  ];
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Set up *Arrs
  services.prowlarr.enable = true;
  services.sonarr = {
    dataDir = "/home/paveloom/.config/sonarr";
    enable = true;
    group = "";
    user = "paveloom";
  };

  # Enable in-memory compression
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 50;

  # Set up Nix
  nix.gc.automatic = true;
  nix.gc.dates = "14:00";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # NixOS version for the stateful data
  system.stateVersion = "22.11";
}
