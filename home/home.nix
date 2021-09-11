{ self, pkgs, ... }:

{
	services.polybar = {
		enable = true;
		script = "polybar bar &";
	};
	xsession.windowManager.i3 = {
		enable = true;
		config = import ./i3.nix;
	};
}
