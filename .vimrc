"Some custom setup script if needed.
if filereadable($HOME . "/.vimrc.before")
	so ~/.vimrc.before
endif

set nocompatible "Vim Users. Not vi users.
set showcmd "Let us be sane on what we're typing.

execute pathogen#infect()
syntax on "We love syntax
filetype on
filetype plugin on
filetype indent on

" --Plugin Configurations
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let wiki = {}
let wiki.path = "~/Projects/vimwiki"
let wiki.ext = ".md"
let wiki.syntax = "markdown"
let wiki.auto_toc = 1
let g:vimwiki_list = [wiki]
let g:vimwiki_markdown_link_ext = 1

" --Display
set title
set number "Line numbers
set ruler
set wrap
set scrolloff=3
set lazyredraw

" --Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" --Tab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" --Beep
set visualbell
set noerrorbells

set backspace=indent,eol,start

set hidden

" --My cute shortcuts
noremap // :nohls<CR>
inoremap jj <Esc>

let mapleader = ","
noremap ,1 1gt
noremap ,2 2gt
noremap ,3 3gt
noremap ,4 4gt
noremap ,5 5gt
noremap ,6 6gt
noremap ,7 7gt
noremap ,8 8gt
noremap ,9 9gt
noremap ,0 10gt

noremap ,e :tabedit<SPACE>
noremap ,q :wq<CR>
noremap ,h :help<SPACE>
noremap ,s :so ~/.vimrc<CR>
noremap ,l :GoMetaLinter ./...<CR>
