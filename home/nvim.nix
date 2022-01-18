{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		coc = {
			enable = true;
			settings = {
				coc.preferences.formatOnSaveFiletypes = [ "gunk" ];
				coc-gunk.server.args = [ "-lint" ];
			};
		};
		vimAlias = true;
		withNodeJs = true;
		plugins = with pkgs.vimPlugins; [
			coc-explorer
			coc-nvim
			coc-clangd
			coc-eslint
			coc-go
			coc-gunk
			coc-svelte
			fzf-vim
			vim-airline
			vim-go
			vim-prettier
			onedark-vim
		];
		extraConfig = builtins.readFile ./vimrc;
	};
}
