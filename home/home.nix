{ self, pkgs, ... }@inputs:

{
	gtk = {
		enable = true;
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
	programs.feh.enable = true;
	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrains Mono";
			size = 12;
		};
	};
	programs.zsh = {
		enable = true;
		enableSyntaxHighlighting = true;
		plugins = [
			{
				name = "powerlevel10k";
				src = pkgs.zsh-powerlevel10k;
				file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
			}
		];
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
