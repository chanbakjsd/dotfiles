{ lib, pkgs, ... }:
{
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
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

			# Use impure Nix instead of Flakes because Flakes enforces the
			# files to be committed to Git
			function mknix() {
				if [ ! -e ./.envrc ]; then
					echo "use nix" > .envrc
					direnv allow
				fi
				if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
					cat ${./shell.nix.default} > default.nix
					vim default.nix
				fi
			}

			bindkey ";5C" forward-word
			bindkey ";5D" backward-word
			bindkey '^H' backward-kill-word
			bindkey '5~' kill-word
		'';
	};
}
