{ pkgs, ... }:

{
	xdg.configFile."nixpkgs/config.nix".text = ''
		{ allowUnfree = true; }
	'';

	home.packages = with pkgs; [
		discord-canary
		bitwarden
		ripgrep
		zoom-us        # Class Requirement
		wl-clipboard
	];

	gtk = {
		enable = true;
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
	programs.kitty = {
		enable = true;
		font = {
			package = pkgs.nerdfonts.override {
				fonts = [ "JetBrainsMono" ];
			};
			name = "JetBrainsMono Nerd Font";
			size = 12;
		};
	};

	services.dunst.enable  = true;
	services.flameshot.enable = true;
	services.gpg-agent.enable = true;
	services.udiskie.enable = true;
	xsession.numlock.enable = true;
}
