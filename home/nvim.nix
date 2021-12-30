{ pkgs, ... }:
{
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
			vim-prettier
			onedark-vim
		];
		extraConfig = builtins.readFile ./vimrc;
	};
}
