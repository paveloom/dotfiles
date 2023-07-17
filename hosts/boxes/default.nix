{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "boxes";
}
