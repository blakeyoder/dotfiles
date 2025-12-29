"  ██████╗ ██╗      █████╗ ██╗  ██╗███████╗███████╗    ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"  ██╔══██╗██║     ██╔══██╗██║ ██╔╝██╔════╝██╔════╝    ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"  ██████╔╝██║     ███████║█████╔╝ █████╗  ███████╗    ██║   ██║██║██╔████╔██║██████╔╝██║
"  ██╔══██╗██║     ██╔══██║██╔═██╗ ██╔══╝  ╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"  ██████╔╝███████╗██║  ██║██║  ██╗███████╗███████║     ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
" This is a fully-featured Vim configuration optimized for web development,
" Python, Rust, and general programming. It uses Vundle for plugin management
" and includes comprehensive settings for modern development workflows.
"
" INSTALLATION INSTRUCTIONS:
"
" 1. Install Vim (8.0+) or Neovim
"    macOS: brew install vim
"    Ubuntu: sudo apt install vim
"
" 2. Install Vundle (Plugin Manager):
"    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" 3. Copy this file to ~/.vimrc:
"    cp vimrc ~/.vimrc
"
" 4. Install plugins:
"    vim +PluginInstall +qall
"
" 5. Install additional dependencies:
"    - ripgrep: brew install ripgrep (for fast searching)
"    - fzf: brew install fzf (for fuzzy file finding)
"    - Node.js: for JavaScript/TypeScript support and some plugins
"
" 6. Install markdown-preview (run inside Vim after PluginInstall):
"    :call mkdp#util#install()
"
" MAIN FEATURES:
"
" • File Management: NERDTree file explorer with intelligent auto-close
" • Git Integration: Fugitive for Git commands, GitGutter for diff visualization
" • Search & Navigation: FZF fuzzy finder, ripgrep integration, quick file switching
" • Code Intelligence: ALE for linting/fixing, goto definition, find references
" • Language Support: JavaScript/TypeScript/JSX, Python, Rust, Markdown, HTML/CSS
" • Productivity: Auto-pairs, surround text objects, smart commenting, emmet
" • UI/UX: Gruvbox theme, airline status bar, buffer management, cursor enhancements
"
" PLUGIN OVERVIEW:
"
" Core Functionality:
" • VundleVim/Vundle.vim - Plugin manager
" • morhetz/gruvbox - Beautiful color scheme
" • vim-airline/vim-airline - Enhanced status line
"
" File & Project Management:
" • scrooloose/nerdtree - File tree explorer (Ctrl+n to toggle)
" • junegunn/fzf + fzf.vim - Fuzzy file finder (Ctrl+p for files)
" • mileszs/ack.vim - Enhanced search capabilities
"
" Git Integration:
" • tpope/vim-fugitive - Git commands in Vim
" • tpope/vim-rhubarb - GitHub integration
" • airblade/vim-gitgutter - Git diff in gutter
"
" Code Intelligence & Linting:
" • w0rp/ale - Asynchronous linting and fixing
" • editorconfig/editorconfig-vim - EditorConfig support
"
" Text Editing & Productivity:
" • tpope/vim-surround - Surround text with quotes/brackets
" • tpope/vim-repeat - Enhance . repeat command
" • jiangmiao/auto-pairs - Auto-close brackets/quotes
" • scrooloose/nerdcommenter - Smart commenting
" • mattn/emmet-vim - HTML/CSS expansion
"
" Language-Specific Support:
" • maxmellon/vim-jsx-pretty - JavaScript/React syntax
" • leafgarland/typescript-vim + peitalin/vim-jsx-typescript - TypeScript
" • rust-lang/rust.vim - Rust language support
" • plasticboy/vim-markdown + iamcco/markdown-preview.nvim - Markdown
" • styled-components/vim-styled-components - CSS-in-JS
" • jparise/vim-graphql - GraphQL syntax
" • elzr/vim-json - Enhanced JSON support
" • tpope/vim-liquid - Liquid templates
"
" Utility Plugins:
" • djoshea/vim-autoread - Auto-reload changed files
" • moll/vim-bbye - Better buffer closing
" • kshenoy/vim-signature - Mark visualization
" • ervandew/supertab - Tab completion
" • heavenshell/vim-jsdoc - JSDoc generation
" • tpope/vim-unimpaired - Handy bracket mappings
" • godlygeek/tabular - Text alignment
" • kana/vim-textobj-user + whatyouhide/vim-textobj-xmlattr - Custom text objects
" • kristijanhusak/vim-js-file-import - Auto-import for JS/TS
" • mlaursen/vim-react-snippets + honza/vim-snippets - Code snippets
" • ruanyl/vim-sort-imports - Sort JS/TS imports
"
" KEY MAPPINGS SUMMARY:
"
" Leader key: <Space>
"
" File Operations:
" • <Space>w - Quick save
" • <Space>q - Quick quit  
" • <Space>sv - Source vimrc
" • Ctrl+n - Toggle NERDTree
" • Ctrl+p - Fuzzy file search
" • Ctrl+f - Find in files (ripgrep)
"
" Buffer Management:
" • <Space>T - New buffer
" • <Space>l - Next buffer
" • <Space>h - Previous buffer
" • <Space>bl - List buffers
" • <Space>bd - Close current buffer
"
" Window Navigation:
" • Ctrl+j/k/l/h - Move between windows
"
" Code Navigation:
" • :Goto - Go to definition (ALE)
" • :Refs - Find references (ALE) 
" • :Docs - Show documentation (ALE)
"
" Editing:
" • jj - Escape to normal mode
" • <Space>a - Select all
" • <Space>y - Copy all
" • <Space><Space> - Clear search highlighting
"
"===============================================================================

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
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'jparise/vim-graphql'
Plugin 'ervandew/supertab'
Plugin 'kana/vim-textobj-user'
Plugin 'whatyouhide/vim-textobj-xmlattr'
Plugin 'rust-lang/rust.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plugin 'heavenshell/vim-jsdoc'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plugin 'styled-components/vim-styled-components', { 'branch': 'main' }
Plugin 'elzr/vim-json'
Plugin 'mlaursen/vim-react-snippets'
Plugin 'honza/vim-snippets'
Plugin 'ruanyl/vim-sort-imports'

call vundle#end()

" For plugins to load correctly
filetype plugin indent on

" React Native / Expo file types
augroup ReactNative
  autocmd!
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile app.json,eas.json,app.config.js set filetype=json
  autocmd BufRead,BufNewFile *.test.tsx set filetype=typescriptreact
augroup END

" Support for @ path aliases in imports
set path+=src/**
set suffixesadd+=.ts,.tsx,.js,.jsx

" Window navigation with Ctrl + hjkl
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

" Quick movement shortcuts
nnoremap <leader>4 $
nnoremap <leader>9 (

" Begin NERDTree
augroup NERDTreeConfig
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeWinSize = 28
let NERDTreeIgnore = ['\.pyc$','__pycache__']
let NERDTreeQuitOnOpen=1

" File handling and undo
set autoread
set history=200
set noswapfile
set ttyfast
set nowritebackup
if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p", 0700)
endif
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set clipboard=unnamed
set cursorline
set synmaxcol=500

" Sign column and gitgutter colors
hi vertsplit ctermfg=238 ctermbg=235
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Python config
augroup PythonConfig
  autocmd!
  autocmd FileType python set colorcolumn=500
augroup END

" Python debug shortcuts
nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>:w
nnoremap <leader>r ofrom remote_pdb import set_trace; set_trace()<Esc>:w

" ALE navigation commands
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
nmap <Leader>bd :Bdelete<CR>
" Faster UI updates (gitgutter, etc.)
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
" Quick save
nnoremap <leader>w :w<CR>
" Quick quit
nnoremap <leader>q :q<CR>
" Quick source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Theme and general styles
set termguicolors
syntax enable
let g:gruvbox_italic=1
colorscheme gruvbox
set belloff=all
set fillchars=vert:\ ,stl:\ ,stlnc:\
set laststatus=2
set noshowmode
set number
set relativenumber
set lazyredraw

" Needs to be _after_ all theme related styles
hi Comment cterm=italic
hi htmlArg cterm=italic
hi Type    cterm=italic

" Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'typescript']
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" Markdown preview settings
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_browser = ''

" Markdown filetype and preview mappings
augroup MarkdownConfig
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown nnoremap <leader>mp :MarkdownPreview<CR>
  autocmd FileType markdown nnoremap <leader>ms :MarkdownPreviewStop<CR>
augroup END

" Python syntax highlighting
let python_highlight_all = 1
let python_version_3 = 1

" ALE (linting and fixing)
let g:airline#extensions#ale#enabled = 1
" Better :sign interface symbols
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_set_balloons = 1

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'javascriptreact': ['prettier', 'eslint'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'json': ['prettier'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint', 'tsserver'],
\}

" React Native specific linting
let g:ale_javascript_eslint_use_global = 0
let g:ale_typescript_eslint_use_global = 0

let g:ale_fix_on_save = 1

" FZF + ripgrep search
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!ios/Pods/*" --glob "!android/.gradle/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
silent! nmap <C-F> :Find<CR>
silent! nmap <C-P> :GFiles<CR>

" Disable mouse
set mouse-=a

" JSON settings
let g:vim_json_syntax_conceal = 0
augroup JSONConfig
  autocmd!
  autocmd FileType json setlocal foldmethod=syntax
  autocmd FileType json normal zR
augroup END

" Quick access to common React Native/Expo files
nnoremap <leader>ep :e package.json<CR>
nnoremap <leader>ea :e app.json<CR>
nnoremap <leader>ec :e app.config.js<CR>
nnoremap <leader>ee :e eas.json<CR>
nnoremap <leader>et :e tsconfig.json<CR>

