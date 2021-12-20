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
	nixpkgs.config.packageOverrides = self.customPkgs;

	environment.pathsToLink = [ "/share/zsh" ]; # Required for autocompletion.
	environment.systemPackages = with pkgs; [
		firefox
		git
		git-crypt
	];

	fonts.fonts = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		jetbrains-mono
		font-awesome
	];

	programs.dconf.enable = true;
	sound.enable = true;
	hardware.pulseaudio.enable = lib.mkForce false;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		jack.enable = true;
		pulse.enable = true;

		alsa.support32Bit = true;
	};

	time.timeZone = "Asia/Kuala_Lumpur";

	networking.networkmanager.enable = true;
	networking.dhcpcd.wait = "background"; # Don't wait and immediately go to background.

	systemd.tmpfiles.rules = [
		"L /home/chanbakjsd/nixos - - - - /persist/nix-config"
		"L /home/chanbakjsd/Projects - - - - /persist/Projects"
		"L /home/chanbakjsd/.ssh - - - - /persist/secrets/.ssh"
		"L /home/chanbakjsd/.gnupg - - - - /persist/secrets/.gnupg"
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
