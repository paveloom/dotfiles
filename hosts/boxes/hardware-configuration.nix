{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # Set up the file system
  fileSystems = {
    "/boot/efi" = {
      device = "/dev/disk/by-partlabel/nixos-boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-partlabel/nixos-data";
      fsType = "btrfs";
      options = ["subvol=@"];
    };
  };

  # Enable SPICE integration for a QEMU guest system
  services.spice-vdagentd.enable = true;

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
