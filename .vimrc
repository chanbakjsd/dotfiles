"Some custom setup script if needed.
if filereadable($HOME . "/.vimrc.before")
	so ~/.vimrc.before
endif

set nocompatible "Vim Users. Not vi users.
set showcmd "Let us be sane on what we're typing.
set rnu "Relative line number

syntax on "We love syntax
filetype on
filetype plugin on
filetype indent on

" --Plugin Configurations
let g:go_metalinter_enabled = [
	\'bodyclose', 'deadcode', 'errcheck', 'goconst','gocritic',  'gocyclo', 'golint', 'gomnd', 'gosimple', 'govet',
	\'ineffassign', 'interfacer', 'lll', 'misspell', 'prealloc', 'staticcheck', 'structcheck', 'typecheck', 'unconvert',
	\'unparam', 'unused', 'varcheck'
	\]
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_command = "gofumpt"
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_lint_delay = 2000 " Geez. Calm down a little.
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let wiki = {}
let wiki.path = "~/Projects/vimwiki"
let wiki.ext = ".md"
let wiki.syntax = "markdown"
let wiki.auto_toc = 1
let g:vimwiki_list = [wiki]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_map_prefix = '<Leader>p'

" --BACKUP
set backup
set backupdir=~/.vim/backup/
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

" --Display
set title
set number "Line numbers
set ruler
set wrap
set scrolloff=3
set lazyredraw
set termguicolors
set foldmethod=indent
set foldlevelstart=8 "Don't fold automatically unless really nested
colorscheme vividchalk

" --Search
set ignorecase
set smartcase
set incsearch
set hlsearch
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" --Tab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" --Beep
set visualbell
set noerrorbells

set backspace=indent,eol,start

set hidden

" --C++ Google Style Formatting
autocmd FileType cpp setlocal shiftwidth=2
autocmd FileType cpp setlocal tabstop=2
autocmd FileType cpp setlocal softtabstop=2
autocmd FileType cpp setlocal expandtab
autocmd FileType cpp setlocal textwidth=80
autocmd FileType cpp setlocal wrap
autocmd FileType cpp setlocal cindent
autocmd FileType cpp setlocal cinoptions=h1,l1,g1,t0,i4,+4,(0,w1,W4
autocmd FileType cpp let g:clang_format#auto_format = 1
autocmd FileType cpp let style = {}
autocmd FileType cpp let style.BasedOnStyle = "Google"
autocmd FileType cpp let g:clang_format#style_options = style

" --Svelte files are essentially HTML
autocmd BufRead,BufNewFile *.svelte set filetype=html

" --Python PEP8
autocmd FileType python let g:ale_fixers = ["autopep8"]
autocmd FileType python let g:ale_fix_on_save = 1

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

" (q)uit, (w)ith path edit, (e)dit, (r)eload
noremap ,q :wqa<CR>
noremap ,w :tabedit<SPACE>
noremap ,e :tabnew<CR>:Files<CR>
noremap ,r :so ~/.vimrc<CR>
" (f)ind in file, (g)rep, (h)elp
noremap ,f :tabnew<CR>:Find<CR>
noremap ,g :vimgrep // **/*.<C-R>=expand('%:e')<CR><C-Left><C-Left><Right>
noremap ,h :help<SPACE>

noremap ,n :cn<CR>
noremap ,p :cp<CR>

autocmd FileType go noremap ,l :GoMetaLinter<SPACE>
autocmd FileType go map ,ll ,l./...<CR>
autocmd FileType go map ,lf ,l"%"<CR>
autocmd FileType go noremap ,c :GoBuild<SPACE>
autocmd FileType go map ,cc ,c.<CR>
autocmd FileType go map ,cf ,c"%"<CR>
autocmd FileType go noremap ,t :GoTest<SPACE>
autocmd FileType go map ,tt ,t./...<CR>
autocmd FileType go noremap ,r :GoRun<SPACE>
autocmd FileType go map ,rr ,r.<CR>
autocmd FileType go map ,rf ,r"%"<CR>
autocmd FileType cpp noremap ,c :!clang++ -Wall -Weffc++ -Wextra -Wsign-conversion -std=c++11 -pedantic-errors<SPACE>
autocmd FileType cpp map ,cf ,c"%"<CR>
autocmd FileType cpp map ,r ,c-o a ;./a;rm a<C-Left><C-Left>
autocmd FileType cpp map ,rf ,r"%"<CR>

" --Macro Template for programming competitions
autocmd FileType cpp noremap ,p :r ~/.macro.cpp<CR>ggdd/\/\/ <VIM TEMPLATE START><CR>ddO
