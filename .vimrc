"-------------------------------------------------------------------------------
" Vim configuration (for Linux 256 colors term - Debian package vim-gtk)
"
" SETUP NEEDED
" cp .vimrc ~/.vimrc
" mkdir -p ~/.vim
" mkdir -p ~/.vim/swap_files/
" mkdir -p ~/.vim/backup_files/
" cp coc-settings.json ~/.vim/coc-settings.json
" sudo apt install yarnpkg #(for coc)
"
" in vim :CocInstall coc-json  coc-vimlsp coc-jedi coc-rust-analyzer
"
" C/C++ completion
" #add apt repository for clangd
" echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster main" >> /etc/apt/sources.list
" wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add -
" apt update && apt install -y clang clangd clang-tools
"
" Rust completion
" :CocInstall coc-rust-analyzer
"
" Python completion (with coc-jedi)
" apt-get install python3-venv
"
" Go completion
" sudo apt install golang
" go get -u github.com/sourcegraph/go-langserver
" sudo cp ~/go/bin/go-langserver /usr/bin
"
" D completion
" sudo wget https://netcologne.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list
" sudo apt-get update --allow-insecure-repositories
" sudo apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring
" sudo apt-get update && sudo apt-get install dmd-compiler dub
" Install serve-d + dcd
" https://github.com/Pure-D/serve-d/releases
" https://github.com/dlang-community/DCD/releases
" https://github.com/dlang-community/D-Scanner/releases
"
" Use with nvim:
" mkdir ~/.config/
" ln -s ~/.vim ~/.config/nvim
" ln -s ~/.vimrc ~/.config/nvim/init.vim

"-------------------------------------------------------------------------------
" use vim
set nocompatible
" change leader key
let mapleader=','

"-------------------------------------------------------------------------------
" Use vim-plug to manage plugin
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Tabular: align text easily
Plug 'godlygeek/tabular'
" Airline: better status line
Plug 'bling/vim-airline'
" colorscheme plugin
Plug 'vim-scripts/wombat256.vim'
" Build in background
Plug 'tpope/vim-dispatch'
" LSP client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Fugitive
Plug 'tpope/vim-fugitive'
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

"-------------------------------------------------------------------------------
" General settings

" automatic plugin + indent + syntax
filetype plugin indent on
syntax on

" no beep or flashing screen
set noerrorbells
set vb t_vb=

" indent
set autoindent
set smartindent

" incremental highlighted search with smartcase
set incsearch
set hlsearch
set ignorecase
set smartcase

" status line for all windows
set laststatus=2

" show current command
set showcmd

" whole line is cursor
set cursorline

" show line number
set number

" show matching elements (brackets, ...)
set showmatch

" when scrolling, leave X lines before and after cursor
set scrolloff=5

" terminal settings - performance and 256 colors
set ttyfast
set t_Co=256
" disable background erase to allow colors to be correct in tmux
set t_ut=

" correct settings for backspace key
set backspace=2

" activate wildmenu for nice autocomplete in commands
set wildmenu
set wildmode=longest,full

" format to 80 chars, using tabs of size 4
set textwidth=80
set colorcolumn=+1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" respect textwidth
autocmd Filetype * set formatoptions+=t

" use system clipboard (copy/paste inside outside vim)
set clipboard=unnamedplus

" bigger history
set history=10000

" tags file found recursively up
set tags=tags;

" ignore some files
set wildignore+=*.o,*.so,*.swp,*.a,*.git/*

" keep swap/bak separately
set backupdir=~/.vim/backup_files
set directory=~/.vim/swap_files

" reduce timeout for some key (faster <esc>)
set timeoutlen=1000
set ttimeoutlen=5

"-------------------------------------------------------------------------------
" General mappings

" format text paragraph
nmap <C-i> mn{v}gq'n

" remove all bad leading/trailing whitespace
nmap <C-d> :%s/\s\+$/<CR>

nnoremap <c-b> :Make<CR>
set makeprg=./build.sh

"----------------------------------------------------------------------------
" Plugins config

" set color
colorscheme wombat256mod
" fix colors
hi ColorColumn ctermbg=236 cterm=none guibg=#32322f
hi SignColumn ctermbg=232 cterm=none guibg=#32322f

" git grep word under cursor
nmap <leader>s :Ggrep <C-R><C-W><CR><CR>:copen<CR>

let g:coc_disable_startup_warning = 1

set hidden
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Show status of current completer
nnoremap <silent> <space>l  :<C-u>CocCommand workspace.showOutput<CR>

" Airline
" trailing whitespace tweak
let g:airline#extensions#whitespace#mixed_indent_algo=1
" customize number of lines (percentage/line/number of lines/col)
let g:airline_section_z = '%p%% %l/%L %c'

" c moves
nnoremap <c-n> :cnext<CR>
nnoremap <c-p> :cprevious<CR>

" FZF files
nmap <C-f> :Files .<CR>

" read meson file like python
autocmd BufNew,BufEnter meson.build setf python

