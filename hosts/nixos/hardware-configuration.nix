{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = [
        "ahci"
        "amdgpu"
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };
    kernel.sysctl = {
      "kernel.perf_event_paranoid" = 1;
    };
    kernelModules = ["kvm-amd"];
  };

  fileSystems = {
    "/boot/efi" = {
      device = "/dev/disk/by-label/NIXOS-BOOT";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/nixos-root";
      fsType = "btrfs";
      options = [
        "compress-force=zstd"
        "subvol=@"
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  services.xserver.videoDrivers = ["amdgpu"];

  swapDevices = [];
}
