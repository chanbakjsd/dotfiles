{ self, pkgs, lib, ... }@inputs:

{
	xdg.configFile."nixpkgs/config.nix".text = ''
		{ allowUnfree = true; }
	'';

	home.packages = with pkgs; [
		discord-canary
		bitwarden
		ripgrep
		zoom-us        # Class Requirement
	];

	gtk = {
		enable = true;
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
	programs.feh.enable = true;
	programs.git = {
		enable = true;
		signing = {
			key = "7E9A74B1B07A7558";
			signByDefault = true;
		};
		userEmail = "lutherchanpublic@gmail.com";
		userName = "Chan Wen Xu";
	};
	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrains Mono";
			size = 12;
		};
	};
	programs.neovim = {
		enable = true;
		coc.enable = true;
		vimAlias = true;
		withNodeJs = true;
		plugins = with pkgs.vimPlugins; [
			coc-explorer
			coc-nvim
			coc-clangd
			coc-eslint
			coc-go
			coc-svelte
			fzf-vim
			vim-airline
			vim-go
			onedark-vim
		];
		extraConfig = builtins.readFile ./vimrc;
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
		sessionVariables = {
			EDITOR = "vim";
		};
		initExtra = ''
			function ghc() { # GitHub Clone
				git clone "ssh://git@github.com/$1"
			}

			bindkey ";5C" forward-word
			bindkey ";5D" backward-word
		'';
	};
	services.dunst.enable  = true;
	services.flameshot.enable = true;
	services.gpg-agent.enable = true;
	services.udiskie.enable = true;
	services.polybar = {
		enable = true;
		script = "polybar bar &";
	};
	xsession = {
		enable = true;
		numlock.enable = true;
		windowManager.i3 = {
			enable = true;
			config = import ./i3.nix inputs;
		};
	};
}
