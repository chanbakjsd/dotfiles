{ lib, pkgs, ...}:
let
	modifier = "Mod4";
	lockText = "(e)xit, (r)estart, (s)hutdown";
	wallpaper = "${pkgs.nixos-artwork.wallpapers.dracula}/share/backgrounds/nixos/nix-wallpaper-dracula.png";
in
{
	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true ;
	};

	wayland.windowManager.sway.config = {
		fonts = {
			names = [ "JetBrains Mono" ];
			size = 12.0;
		};

		input = {
			"*" = {
				xkb_options = "caps:escape";
				xkb_numlock = "enable";
			};
		};

		output = {
			"*" = {
				bg = "${wallpaper} fill";
			};
		};

		floating.titlebar = true;
		window.titlebar = true;

		focus.mouseWarping = false;
		modifier = modifier;
		keybindings = lib.mkOptionDefault {
			"${modifier}+d" = "kill";
			"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
			"${modifier}+o" = "exec ${pkgs.flameshot}/bin/flameshot gui";
			"${modifier}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
			"${modifier}+Mod1+z" = "exec ${pkgs.swaylock-effects}/bin/swaylock --indicator --effect-blur 5x5 --screenshots --clock --datestr '%a, %F' --indicator-radius 100 --fade-in 0.2";

			"${modifier}+Shift+q" = ''mode "${lockText}"'';

			"${modifier}+h" = "focus left";
			"${modifier}+j" = "focus down";
			"${modifier}+k" = "focus up";
			"${modifier}+l" = "focus right";
			"${modifier}+Shift+h" = "move left";
			"${modifier}+Shift+j" = "move down";
			"${modifier}+Shift+k" = "move up";
			"${modifier}+Shift+l" = "move right";

			"${modifier}+Shift+r" = "reload";

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
				"e" = "exec ${pkgs.sway}/bin/swaymsg exit";
				"r" = "exec systemctl reboot";
				"s" = "exec systemctl poweroff -i";
				"Escape" = "mode default";
				"Return" = "mode default";
			};
		};
	};
}
