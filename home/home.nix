{ self, pkgs, lib, ... }@inputs:

{
	xdg.configFile."nixpkgs/config.nix".text = ''
		{ allowUnfree = true; }
	'';

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
			{
				name = "p10k-config";
				src = lib.cleanSource ./p10k-config;
				file = "p10k.zsh";
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
