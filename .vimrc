"-------------------------------------------------------------------------------
"Vim configuration (for Linux 256 colors term - Debian package vim-gtk)
"
" SETUP NEEDED
" cp .vimrc ~/.vimrc
" mkdir -p ~/.vim
" mkdir -p ~/.vim/swap_files/
" mkdir -p ~/.vim/backup_files/
" mkdir -p ~/.config/
" ln -s ~/.vim ~/.config/nvim
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" cp coc-settings.json ~/.vim/coc-settings.json
" sudo apt install yarnpkg #(for coc)
"
" in vim:
" :CocInstall coc-clangd coc-docker coc-json coc-marketplace coc-jedi
" :CocInstall coc-rust-analyzer coc-sh coc-toml coc-vimlsp coc-yaml
"
" # too see all extensions CocList marketplace
" :CocList marketplace
"-------------------------------------------------------------------------------
"use vim
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
Plug 'bling/vim-airline' " status line
Plug 'neoclide/coc.nvim', {'branch': 'release'} " auto complete
Plug 'tpope/vim-dispatch' " :Make command
Plug 'tpope/vim-fugitive' " git
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder for files
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/wombat256.vim' " theme
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

" let end of file like it is
set nofixendofline

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
nmap <C-l> mn{v}gq'n

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
nmap <silent> gh :<C-u>CocCommand clangd.switchSourceHeader<CR>

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
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
