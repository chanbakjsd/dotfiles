{ lib, pkgs, ...} :
let
	modifier = "Mod4";
	lockText = "(e)xit, (r)estart, (s)hutdown";
	wallpaper = "${pkgs.nixos-artwork.wallpapers.dracula}/share/backgrounds/nixos/nix-wallpaper-dracula.png";
	keyboardMap = pkgs.writeText "xkb-layout" ''
		clear Lock
		keycode 66 = Tab ISO_Left_Tab Tab ISO_Left_Tab
	'';
in
{
	fonts = {
		names = [ "JetBrains Mono" ];
		size = 12.0;
	};

	startup = [
		{ command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}"; notification = false; }
		{ command = "${pkgs.xorg.xmodmap}/bin/xmodmap ${keyboardMap}"; notification = false; }
	];

	focus.mouseWarping = false;
	modifier = modifier;
	keybindings = lib.mkOptionDefault {
		"${modifier}+d" = "kill";
		"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
		"${modifier}+o" = "exec ${pkgs.flameshot}/bin/flameshot gui";
		"${modifier}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
		"${modifier}+Mod1+z" = "exec ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 3";

		"${modifier}+Shift+q" = ''mode "${lockText}"'';

		"${modifier}+h" = "focus left";
		"${modifier}+j" = "focus down";
		"${modifier}+k" = "focus up";
		"${modifier}+l" = "focus right";
		"${modifier}+Shift+h" = "move left";
		"${modifier}+Shift+j" = "move down";
		"${modifier}+Shift+k" = "move up";
		"${modifier}+Shift+l" = "move right";

		"${modifier}+Ctrl+1" = "move container to workspace 1;workspace 1";
		"${modifier}+Ctrl+2" = "move container to workspace 2;workspace 2";
		"${modifier}+Ctrl+3" = "move container to workspace 3;workspace 3";
		"${modifier}+Ctrl+4" = "move container to workspace 4;workspace 4";
		"${modifier}+Ctrl+5" = "move container to workspace 5;workspace 5";
		"${modifier}+Ctrl+6" = "move container to workspace 6;workspace 6";
		"${modifier}+Ctrl+7" = "move container to workspace 7;workspace 7";
		"${modifier}+Ctrl+8" = "move container to workspace 8;workspace 8";
		"${modifier}+Ctrl+9" = "move container to workspace 9;workspace 9";
		"${modifier}+Ctrl+0" = "move container to workspace 10;workspace 10";
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
