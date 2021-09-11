{ self, pkgs, ... }:

{
	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrains Mono";
			size = 12;
		};
	};

	services.polybar = {
		enable = true;
		script = "polybar bar &";
	};
	xsession.windowManager.i3 = {
		enable = true;
		config = import ./i3.nix;
	};
}
