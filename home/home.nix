{ self, pkgs, ... }@inputs:

{
	gtk = {
		enable = true;
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrains Mono";
			size = 12;
		};
	};
	services.flameshot.enable = true;
	services.polybar = {
		enable = true;
		script = "polybar bar &";
	};
	xsession.windowManager.i3 = {
		enable = true;
		config = import ./i3.nix inputs;
	};
}
