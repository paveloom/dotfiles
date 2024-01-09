{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = [
        "ahci"
        "sr_mod"
        "virtio_blk"
        "virtio_pci"
        "xhci_pci"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
  };

  fileSystems = {
    "/boot/efi" = {
      device = "/dev/disk/by-partlabel/nixos-boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-partlabel/nixos-root";
      fsType = "btrfs";
      options = [
        "compress-force=zstd"
        "subvol=@"
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = false;

  nixpkgs.hostPlatform = "x86_64-linux";

  services.spice-vdagentd.enable = true;

  swapDevices = [];
}
