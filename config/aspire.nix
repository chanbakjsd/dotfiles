{ config, pkgs, lib, ... }:

{
	nix.buildCores = 1;
	nix.maxJobs = 2;

	nixpkgs.config.allowUnfree = true;

	boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/97b23bd6-cca7-499c-9589-a74ce3205731";
	boot.loader.grub = {
		enable = true;
		version = 2;
		device = "/dev/sda";
		useOSProber = true;
	};

	networking = {
		hostName = "aspire";

		# useDHCP is deprecated, disable explicitly.
		useDHCP = false;
		interfaces.enp2s0f0.useDHCP = true;
	};

	services.xserver.libinput.enable = true;

	system.stateVersion = "21.05";
}
