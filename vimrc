" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Personal .vimrc file with a few lines to import corp .vimrc.
"
" All the plugins are managed via vim-plug, run :PlugInstall to install all
" the plugins from Github, :PlugUpdate to update. Leader key is the spacebar.
"
" What function keys do (also see: Custom commands, Leader shortcuts):
"   F5: toggle Gundo window.

" => Pre-load ------------------------------------------------------------- {{{1

filetype plugin indent on

" Download and install vim-plug (cross platform).
if empty(glob(
    \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
    \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') . 
    \ '/autoload/plug.vim --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load Google-specific .vimrc if it exists.
if !empty(glob('$HOME/.vimrc.google'))
  source $HOME/.vimrc.google
endif

" => Sane defaults (from Neovim) ------------------------------------------ {{{1

if !has('nvim')
  syntax on

  set autoindent
  set autoread
  set backspace=indent,eol,start
  set belloff=all
  set complete-=i
  set display=lastline
  set formatoptions=tcqj
  set history=10000
  set incsearch
  set laststatus=2
  set nocompatible
  set ruler
  set sessionoptions-=options
  set showcmd
  set sidescroll=1
  set smarttab
  set ttimeoutlen=50
  set ttyfast
  set viminfo+=!
  set wildmenu
endif

" => vim-plug plugins ----------------------------------------------------- {{{1

call plug#begin()

Plug 'EinfachToll/DidYouMean'                    " filename suggestions
Plug 'Lokaltog/vim-easymotion'                   " better move commands
Plug 'brooth/far.vim', {'on': 'Far'}             " global search and replace
Plug 'christoomey/vim-tmux-navigator'            " better tmux integration
Plug 'ervandew/supertab'                         " more powerful <tab>
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}         " distraction-free writing
Plug 'kien/ctrlp.vim'                            " <ctrl-p> to fuzzy search
Plug 'mileszs/ack.vim', {'on': 'Ack'}            " ack integration
Plug 'tomtom/tcomment_vim'                       " commenting helpers
Plug 'tpope/vim-abolish'                         " change case on the fly
Plug 'tpope/vim-repeat'                          " repeat everything
Plug 'tpope/vim-surround'                        " better surround commands
Plug 'tpope/vim-unimpaired'                      " pairs of helpful commands
Plug 'tpope/vim-vinegar'                         " - to open netrw
Plug 'vim-scripts/Gundo', {'on': 'GundoToggle'}  " visualize the undo tree
Plug 'vim-scripts/vimwiki'                       " personal wiki

Plug 'NLKNguyen/papercolor-theme'                " colorscheme
Plug 'ajh17/Spacegray.vim'                       " colorscheme
Plug 'altercation/vim-colors-solarized'          " colorscheme
Plug 'squarefrog/tomorrow-night.vim'             " colorscheme

call plug#end()

" => Editing -------------------------------------------------------------- {{{1

" Global indentation settings.
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Disable backups and .swp files.
set nobackup
set noswapfile
set nowritebackup

" Semicolon is too long to type.
nnoremap ; :
vnoremap ; :

" Map leader key.
let mapleader = "\<Space>"

" Use system clipboard.
set clipboard=unnamed,unnamedplus

" Enable wild menu (tab command autocompletion).
set wildmode=list:longest,full

" Don't complain about unsaved files when switching buffers.
set hidden

" Enable persistent undo.
set undofile
set undodir=$HOME/.vim/undodir

" => Looks ---------------------------------------------------------------- {{{1

set background=light
colorscheme PaperColor

" Shorten press ENTER to continue messages.
set shortmess=atI

" Highlight cursor line.
set cursorline

" Display line numbers if terminal is wide enough.
if &co > 80
  set number
endif

" Soft word wrap.
set linebreak

" Make soft line breaks much better looking.
set breakindent

" Pretty soft break character.
let &showbreak = '> '

" => Custom commands ------------------------------------------------------ {{{1

" Command to close current buffer without closing the window.
command! Bd :bp | :sp | :bn | :bd

" => Leader shortcuts ----------------------------------------------------- {{{1

nnoremap <Leader>] <C-]>
nnoremap <Leader>i <C-i>
nnoremap <Leader>o <C-o>
nnoremap <Leader>p :CtrlP<cr>
nnoremap <Leader>t :CtrlPTag<cr>
nnoremap <Leader>r :redraw!<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>a :Ack! <C-r><C-w><cr>

" => Movement and search -------------------------------------------------- {{{1

" Ignore case when searching.
set ignorecase
set smartcase

" Fast split navigation.
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Absolute movement for word-wrapped lines.
nnoremap j gj
nnoremap k gk

" => Misc ----------------------------------------------------------------- {{{1

" Use Unix as the standart file type.
set ffs=unix,dos,mac

" Fold using {{{n, where n is fold level
set foldmethod=marker

" => Fixes and hacks ------------------------------------------------------ {{{1

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
endif

" Unfold all files by default.
au BufRead * normal zR

" Fix easymotion target colors in a PaperColor theme.
if g:colors_name ==# 'PaperColor'
  hi EasyMotionTarget2First ctermbg=none ctermfg=red
endif

" => Plugins configuration ------------------------------------------------ {{{1

" Gundo.
let g:gundo_preview_bottom = 1
nnoremap <F5> :GundoToggle<cr>

" Vinegar.
autocmd FileType netrw setl bufhidden=wipe

" VimWiki.
let g:vimwiki_list = [{
  \ 'path': '$HOME/Dropbox/wiki',
  \ 'template_path': '$HOME/Dropbox/wiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]
let g:vimwiki_dir_link = 'index'
