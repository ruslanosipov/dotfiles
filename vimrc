" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Personal .vimrc file with a few lines to import corp .vimrc.
"
" All the plugins are managed via vim-plugin, run :PlugInstall to install all
" the plugins from Github, :PlugUpdate to update. Leader key is the spacebar.
"
" What function keys do (also see: Custom commands, Leader shortcuts):
"   F5: toggle Gundo window.

" => Pre-load ------------------------------------------------------------- {{{1

filetype plugin indent on

" Download and install vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load Google-specific .vimrc if it exists.
if !empty(glob('$HOME/.vimrc.google'))
  source $HOME/.vimrc.google
endif

" => vim-plug plugins ----------------------------------------------------- {{{1

call plug#begin()

Plug 'EinfachToll/DidYouMean'
Plug 'Lokaltog/vim-easymotion'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/Spacegray.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'burnettk/vim-angular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ciaranm/detectindent'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'motemen/git-vim'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'squarefrog/tomorrow-night.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/DirDiff.vim'
Plug 'vim-scripts/Gundo'
Plug 'vim-scripts/ScrollColors'
Plug 'vim-scripts/vimwiki'

call plug#end()

" => Editing -------------------------------------------------------------- {{{1

syntax on

" Indentation settings.
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

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
set clipboard=unnamedplus

" Enable wild menu (tab command autocompletion).
set wildmenu
set wildmode=list:longest,full

" Don't complain about unsaved files when switching buffers.
set hidden

" Make soft line breaks much better looking.
if v:version > 703
  set breakindent
endif

" Pretty soft break character.
let &showbreak='↳ '

" => Looks ---------------------------------------------------------------- {{{1

set background=dark
colorscheme spacegray

" Set terminal window title and set it back on exit.
set title
let &titleold = getcwd()

" Shorten press ENTER to continue messages.
set shortmess=atI

" Show last command.
set showcmd

" Highlight cursor line.
set cursorline

" Ruler (line, column and % at the right bottom).
set ruler

" Display line numbers if terminal is wide enough.
if &co > 80
  set number
endif

" Soft word wrap.
set linebreak

" Prettier display of long lines of text.
set display+=lastline

" Always show statusline.
set laststatus=2

" => Custom commands ------------------------------------------------------ {{{1

" Command to close current buffer without closing the window.
command Bd :bp | :sp | :bn | :bd

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

" => Filetype-specific ---------------------------------------------------- {{{1

" Linewrap for git commit messages.
augroup filetype_gitcommit
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END
"
" Enforce text width in VimWiki.
augroup filetype_vimwiki
  autocmd!
  autocmd Filetype vimwiki setlocal textwidth=80
augroup END

" Treat all HTML as Django templates.
augroup html_django
  autocmd!
  au BufNewFile,BufRead *.html set ft=htmldjango
augroup END

" => Misc ----------------------------------------------------------------- {{{1

" Use Unix as the standart file type.
set ffs=unix,dos,mac

" Ignore compiled files.
set wildignore=*.o,*~,*.pyc,*.pyo

" Ignore virtualenv directory.
set wildignore+=env

" Fold using {{{n, where n is fold level
set foldmethod=marker

" => Fixes and hacks ------------------------------------------------------ {{{1

" Ignore mouse (in GVIM).
set mouse=c

" Fix backspace behavior in GVIM.
set bs=2

" NERDTree arrows in Windows.
if has("win32") || has("win64") || has("win32unix")
  let g:NERDTreeDirArrows = 0
endif

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
endif

" Unfold all files by default.
au BufRead * normal zR

" => Plugins configuration ------------------------------------------------ {{{1

" NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Gundo.
let g:gundo_preview_bottom = 1
nnoremap <F5> :GundoToggle<cr>

" VimWiki.
let g:vimwiki_list = [{
  \ 'path': '$HOME/Dropbox/wiki',
  \ 'template_path': '$HOME/Dropbox/wiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]
let g:vimwiki_dir_link = 'index'
