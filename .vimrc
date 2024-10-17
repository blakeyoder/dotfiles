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
Plugin 'tpope/vim-liquid'
Plugin 'vim-airline/vim-airline'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'djoshea/vim-autoread'
Plugin 'scrooloose/nerdcommenter'
Plugin 'moll/vim-bbye'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mileszs/ack.vim'
Plugin 'w0rp/ale'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ervandew/supertab'
Plugin 'kana/vim-textobj-user'
Plugin 'whatyouhide/vim-textobj-xmlattr'
Plugin 'rust-lang/rust.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plugin 'styled-components/vim-styled-components'
Plugin 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}

call vundle#end()

" For plugins to load correctly
filetype plugin indent on

" move windows with leader plus natural keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set leader to space
let mapleader = " "

" select all
nnoremap <leader>a ggVG<CR>

" copy all
nnoremap <leader>y ggVGy<CR>

nnoremap <leader>4 $
nnoremap <leader>9 (

" use mouse for intellisense
set mouse=a

" Begin NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeWinSize = 28
let NERDTreeIgnore = ['\.pyc$','__pycache__']
let NERDTreeQuitOnOpen=1

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
set cursorline
set synmaxcol=180

" Gitgutter options
hi vertsplit ctermfg=238 ctermbg=235
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" JS syntax highlighting
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Python mode settings
let g:pymode_folding = 0
autocmd FileType python set colorcolumn=500 " dont care to see the verical column
nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>:w
nnoremap <leader>r ofrom remote_pdb import set_trace; set_trace()<Esc>:w

" helpful goto statements
:command Goto ALEGoToDefinition
:command Refs ALEFindReferences
:command Docs ALEDocumentation

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
" Turn off recording
map q <Nop>

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
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

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
let python_version_3 = 1

" Python specific configs
"""""""""""""""""""""""""
let g:airline#extensions#ale#enabled = 1
" Better :sign interface symbols
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_set_balloons = 1

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\}

let g:ale_fix_on_save = 1

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
silent! nmap <C-F> :Find<CR>
silent! nmap <C-P> :GFiles<CR>

set mouse-=a
