" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Personal .vimrc file.

" => Pre-load ------------------------------------------------------------ {{{1

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" => Editing --------------------------------------------------------------{{{1

syntax on

" Indentation settings.
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Disable backups and .swp files.
set nobackup
set nowritebackup
set noswapfile

" Ignore case when searching.
set ignorecase
set smartcase

" Linewrap for git commit messages.
autocmd Filetype gitcommit setlocal spell textwidth=72

" Wrap text in VimWiki.
autocmd Filetype vimwiki setlocal textwidth=80

" Semicolon is too long to type.
nnoremap ; :

" Comma is much better as a leader.
let mapleader = ","

" Navigate the wrapped lines easier.
nnoremap j gj
nnoremap k gk

" Trim EOL whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

" Syntax highlighting in fc.
if expand('%:t') =~?'bash-fc-\d\+'
  setfiletype sh
endif

" => Looks --------------------------------------------------------------- {{{1

set background=dark
colorscheme spacegray

" Set terminal window title and return it back on exit.
set title
let &titleold = getcwd()

" Shorten press ENTER to continue messages.
set shortmess=atI

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
endif

" Show last command.
set showcmd

" Highlight cursor line.
set cursorline

" Ruler (line, column and % at the right bottom).
set ruler

" Enable wild menu (tab command autocompletion).
set wildmenu
set wildmode=list:longest,full

" Soft word wrapping.
set linebreak

" Display line numbers if terminal is wide enough.
if &co > 80
  set number
endif

" Prettier display of long lines of text.
set display+=lastline

" Set font and disable all GUI options in GVim.
if has("gui_running")
  set guifont=Source\ Code\ Pro\ for\ Powerline:h18
  set guioptions=
endif

" => Misc ---------------------------------------------------------------- {{{1

" Fast split navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use Unix as the standard file type.
set ffs=unix,dos,mac

" Enable filetype plugins.
filetype plugin on
filetype indent on

" Ignore compiled files.
set wildignore=*.o,*~,*.pyc,*.pyo

" Ignore virtualenv directory.
set wildignore+=env

" Fold using {{{n, where n is fold level
set foldmethod=marker

" => Fixes --------------------------------------------------------------- {{{1

" Ignore mouse and fix backspace behavior in gvim.
set mouse=c
set backspace=2

" NERDTree arrows in Windows.
if has("win32") || has("win64") || has("win32unix")
  let g:NERDTreeDirArrows = 0
endif

" Solarized Mac compatibility.
if !has('gui_running')
  let g:solarized_termtrans = 1
  let g:solarized_termcolors = 16
endif

" => Plugins ------------------------------------------------------------- {{{1

" DetectIndent: automatically detect.
autocmd BufReadPost * :DetectIndent

" NERDTree: ignore compiled files.
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" NERDTree: toggle.
nnoremap <Leader>nt :NERDTreeToggle<CR>

" Exuberant Ctags: autogenerate on py file write.
autocmd BufWritePost *.py silent! !ctags --exclude=env -R *.py &

" Pydoc: open in new tab instead of split.
let g:pydoc_open_cmd = 'tabnew'

" Pydoc: disable search term highlight.
let g:pydoc_highlight = 0

" Map Gundo.
nnoremap <F5> :GundoToggle<CR>

" SimpylFold: Do not fold docstrings.
let g:SimpylFold_fold_docstring = 0

" VimWiki: default location.
let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki'}]
