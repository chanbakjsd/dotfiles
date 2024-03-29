# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f7853517-9c5c-497f-a749-17171320d45f";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/f7853517-9c5c-497f-a749-17171320d45f";
      fsType = "btrfs";
      options = [ "subvol=@persist" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/c6d4b892-09fd-48ee-97ee-3509af5cd873";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/627E-7033";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/f7853517-9c5c-497f-a749-17171320d45f";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3430af3a-484c-40b6-a278-d38b042abd21"; }
    ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
