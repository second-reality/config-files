"-------------------------------------------------------------------------------
" Vim configuration (optimized for terminals and Linux)
"
" Plugins installed are:
" matchit :		extends vim %
" NERD_commenter :	easy commenting
" NERD_tree :		navigate in your files
" OmniCppComplete :	complete your code
" SrcExplorer :		navigate in your project
" SuperTab :		Tab does everything for you
" Surround :		easy way to surround expressions
" Taglist :		show all symbols in the current file
" Trinity :		join NERD_tree, SrcExplorer and TagList for the best
" Tabular :		Easily align code at given character
"
" Note that ctags must be in your $PATH to use some of these plugins.
"
" Theme installed is:
" wombat256mod : a theme for vim
"
" install:
" linux: ~/.vimrc, ~/.vim
" windows: ~/.vimrc, ~/vimfiles
"-------------------------------------------------------------------------------
" General settings

" use vim
set nocompatible

" automatic plugin + indent + syntax
filetype plugin indent on
syntax on

" no beep or flashing screen
set noerrorbells
set vb t_vb=""

" indent
set autoindent
set smartindent

" default behaviour for backspace
set backspace=2

" incremental highlighted search
set incsearch
set hlsearch

" status line for all windows
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" whole line is cursor
set cursorline

" show line number
set number

" show part matching current one
set showmatch

" when scrolling, leave X lines before and after cursor
set scrolloff=3

" enable folding
set foldenable

" tab settings - use spaces, 8 characters
set softtabstop=8
set shiftwidth=8
set tabstop=8
set expandtab

" terminal settings - performance, mouse use and 256 colors
set ttyfast
set mouse=a
set t_Co=256
" disable background erase to allow tmux to work
set t_ut=

" tags recursive lookup
set tags=tags;/

"-------------------------------------------------------------------------------
" Visual style
colorscheme wombat256mod

" custom highlights
" text after 80 column
highlight MoreThan80Chars guibg=gray26
let m = matchadd('MoreThan80Chars', '\%>80v.\+')

" trailing whitespace
highlight TrailingWS guibg=LightRed
let m = matchadd('TrailingWS', '[ \t]\+$')

" bad leading whitespace
highlight BadLeadingWS guibg=LightRed
let m = matchadd('BadLeadingWS', '^[ \t]\+$')

"no matches
"let m = clearmatches()

"-------------------------------------------------------------------------------
" Plugins

" Map leader key
let mapleader = ','

" SuperTab ultimate behavior
let g:SuperTabDefaultCompletionType = "context"

" launch full Trinity
nmap <F8> :TrinityToggleAll<CR>

"-------------------------------------------------------------------------------
" Text edition

" don't go after 80 column
autocmd BufNewFile,BufRead *.txt set textwidth=80
autocmd BufNewFile,BufRead *.rst set textwidth=80

" format (80 chars) text paragraph
nmap <C-i> mn{v}gq'n

" format (80 chars) all text
nmap <C-g> mnggvGgq'n

"-------------------------------------------------------------------------------
" Magic commands

" format (80 chars) text paragraph
nmap <C-i> mn{v}gq'n

" Copy buffer
nmap <C-a> mnggvGy'n

" format (80 chars) all text
nmap <C-g> mnggvGgq'n

" search text under cursor
nmap <F2> viwy/<C-r>0<CR>

" save and quit everything
nmap <F4> :wqa<CR>

" generate 'tags' recursively for current directory
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" reload vim documentation
nmap <F11> :helptags ~/.vim/doc

" move between windows easily
nmap <C-l> <C-W>l
nmap <C-k> <C-W>k
nmap <C-j> <C-W>j
nmap <C-h> <C-W>h
