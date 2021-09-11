{ self, home-manager, ... }:
{ config, pkgs, lib, ... }:

{
	imports = [
		home-manager.nixosModules.home-manager {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.chanbakjsd = import ../home/home.nix;
		}
	];

	nix.package = pkgs.nixUnstable;
	nix.extraOptions = "experimental-features = nix-command flakes";

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.packageOverrides = pkgs: {
		os-prober = pkgs.os-prober.overrideAttrs (ori: {
			patches = [ ./pkg/os-prober.patch ]; # OS Prober is awfully slow in detecting Linux distros.
		});
	};

	environment.pathsToLink = [ "/share/zsh" ]; # Required for autocompletion.
	environment.systemPackages = with pkgs; [
		firefox
		git
		git-crypt
		vim
	];

	fonts.fonts = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		jetbrains-mono
	];

	sound.enable = true;
	hardware.pulseaudio.enable = true;

	time.timeZone = "Asia/Kuala_Lumpur";

	networking.networkmanager.enable = true;
	networking.dhcpcd.wait = "background"; # Don't wait and immediately go to background.

	systemd.tmpfiles.rules = [
		"L /home/chanbakjsd/nixos - - - - /persist/nix-config"
		"L /home/chanbakjsd/Projects - - - - /persist/Projects"
	];

	services.xserver = {
		enable = true;
		displayManager.sddm.enable = true;
		windowManager.i3.enable = true;
	};

	programs.zsh.enable = true;

	users = {
		mutableUsers = false; # Force all users to be declared
		users.chanbakjsd = {
			isNormalUser = true;
			extraGroups = [ "wheel" "networkmanager" ];
			hashedPassword = self.secrets.passwordHash;
			shell = pkgs.zsh;
		};
	};

}
