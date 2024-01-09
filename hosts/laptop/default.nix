{...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";
}
