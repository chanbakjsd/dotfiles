{ config, pkgs, lib, ... }:

{
	nix.settings = {
		cores = 4;
		max-jobs = 4;
	};

	nixpkgs.config.allowUnfree = true;

	boot.kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;

	boot.loader = {
		efi.efiSysMountPoint = "/boot/efi";
		grub.efiSupport = true;
		grub.device = "nodev";
	};
	boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/3b7f1053-adb0-4ab3-be45-e4570eb867e2";

	networking = {
		hostName = "nitro";

		# useDHCP is deprecated, disable explicitly.
		useDHCP = false;
		interfaces.enp3s0.useDHCP = true;
	};

	services.xserver.libinput.enable = true;

	system.stateVersion = "22.05";
}

