{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "vm";
}
