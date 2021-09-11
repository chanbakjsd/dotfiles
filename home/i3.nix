{ lib, pkgs, ...} :
let
	modifier = "Mod4";
	lockText = "(e)xit, (r)estart, (s)hutdown";
	wallpaper = "${pkgs.nixos-artwork.wallpapers.dracula}/share/backgrounds/nixos/nix-wallpaper-dracula.png";
in
{
	fonts = {
		names = [ "JetBrains Mono" ];
		size = 12.0;
	};

	startup = [
		{ command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}"; notification = false; }
	];

	focus.mouseWarping = false;
	modifier = modifier;
	keybindings = lib.mkOptionDefault {
		"${modifier}+d" = "kill";
		"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
		"${modifier}+o" = "exec ${pkgs.flameshot}/bin/flameshot gui";
		"${modifier}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";

		"${modifier}+Shift+q" = ''mode "${lockText}"'';

		"${modifier}+h" = "focus left";
		"${modifier}+j" = "focus down";
		"${modifier}+k" = "focus up";
		"${modifier}+l" = "focus right";
		"${modifier}+Shift+h" = "move left";
		"${modifier}+Shift+j" = "move down";
		"${modifier}+Shift+k" = "move up";
		"${modifier}+Shift+l" = "move right";
	};
	modes = lib.mkOptionDefault {
		"(e)xit, (r)estart, (s)hutdown" = {
			"e" = "exec ${pkgs.i3}/bin/i3-msg exit";
			"r" = "exec systemctl reboot";
			"s" = "exec systemctl poweroff -i";
			"Escape" = "mode default";
			"Return" = "mode default";
		};
	};
}
