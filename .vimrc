"  ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄
" ███    ███ ███  ▄██▀▀▀███▀▀▀██▄
" ███    ███ ███▌ ███   ███   ███
" ███    ███ ███▌ ███   ███   ███
" ███    ███ ███▌ ███   ███   ███
" ███    ███ ███  ███   ███   ███
" ███    ███ ███  ███   ███   ███
"  ▀██████▀  █▀    ▀█   ███   █▀

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'djoshea/vim-autoread'
Plugin 'IN3D/vim-raml'
Plugin 'scrooloose/nerdcommenter'
Plugin 'moll/vim-bbye'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mileszs/ack.vim'
Plugin 'w0rp/ale'
Plugin 'tell-k/vim-autopep8'
Plugin 'raimon49/requirements.txt.vim'

call vundle#end()

" For plugins to load correctly
filetype plugin indent on

" move windows with leader plus natural keys
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" set leader to space
let mapleader = " "

" select all
nnoremap <leader>a ggVG<CR>

" copy all
nnoremap <leader>y ggVGy<CR>

" upper or lowercase the current word
nnoremap <leader>u gUiW
nnoremap <leader>v guiW

" Begin NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeWinSize = 40
let NERDTreeIgnore = ['\.pyc$']

" background processes
set autoread "update file when changed outside of vim
set history=200
set noswapfile
set ttyfast
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set clipboard=unnamed

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$|vendor\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.pyc$\|\.dat$'
  \ }

" Gitgutter options
hi vertsplit ctermfg=238 ctermbg=235
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Python mode settings
let g:pymode_folding = 0
autocmd FileType python set colorcolumn=500 " dont care to see the verical column

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
" Closes current buffer and moves to previous buffer
nmap <Leader>q :Bdelete<CR>

" let vim recongize changes a tad quicker
set updatetime=250

" Security
set modelines=0

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Map jj to escape sequence 
inoremap jj <ESC>

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Theme and general styls
set termguicolors
syntax enable
colorscheme gruvbox
let g:gruvbox_italic=1
set belloff=all
set fillchars=vert:\ ,stl:\ ,stlnc:\
set laststatus=2
set noshowmode
set number

" Needs to be _after_ all theme related styles
hi Comment cterm=italic
hi htmlArg cterm=italic
hi Type    cterm=italic

" Begin python syntax hi
let python_highlight_all = 1
let python_version_2 = 1

" Python specific configs
"""""""""""""""""""""""""
" We like spaces; avoid tabs. Set colorcolumn.
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4 colorcolumn=80

" W0rp/ale linter config
let g:ale_python_flake8_args="--ignore=E501,E128"
let g:ale_fixers = {
\   'python': ['flake8'],
\}
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_warning = '-'
let g:ale_sign_error = 'x'
