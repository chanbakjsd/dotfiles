{ self, home-manager, nixpkgs, ... }:
{ config, pkgs, lib, ... }:

let
	gtkgreetSwayWrapper = pkgs.writeText "gtkgreet-sway" ''
		# `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
		exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"

		bindsym Mod4+shift+q exec swaynag \
			-t warning \
			-m 'What do you want to do?' \
			-b 'Poweroff' 'systemctl poweroff' \
			-b 'Reboot' 'systemctl reboot'

		include /etc/sway/config.d/*
	'';
in
{
	imports = [
		home-manager.nixosModules.home-manager {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.chanbakjsd = {
				imports = import ../home;
			};
		}
	];

	nix = {
		package = pkgs.nixUnstable;
		extraOptions = "experimental-features = nix-command flakes";
		nixPath = [
			"nixpkgs=${nixpkgs.outPath}"
		];
	};

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.packageOverrides = self.customPkgs;

	boot.supportedFilesystems = [ "ntfs" ];

	environment.pathsToLink = [ "/share/zsh" ]; # Required for autocompletion.
	environment.systemPackages = with pkgs; [
		firefox
		git
		git-crypt
		steam-run-native
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

	programs.sway = {
		enable = true;
		extraPackages = with pkgs; [ waybar ];
		wrapperFeatures.gtk = true;
	};

	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.sway}/bin/sway --config ${gtkgreetSwayWrapper}";
			};
		};
	};
	environment.etc."greetd/environments".text = "${pkgs.sway}/bin/sway";

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
