" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Personal/corporate .vimrc file.
"
" All the plugins are managed via Vundle, run :PluginInstall to install all
" the plugins from Github, :PluginUpdate to update. Leader key is the
" spacebar.
"
" What function keys do (also see: Custom commands, Leader shortcuts):
"   F5: toggle Gundo window.
"   F8: toggle Tagbar window.
"   F10 (Google-specific): show corresponding test/build/etc files.

" => Constants ------------------------------------------------------------ {{{1

let usegooglevim = 0

" => Pre-load ------------------------------------------------------------- {{{1

set nocompatible
filetype plugin indent on

" Required Vundle setup.
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" Load core Google plugins.
if (usegooglevim)
  source /usr/share/vim/google/core.vim
endif

" => Vundle plugins ------------------------------------------------------- {{{1

Plugin 'gmarik/vundle'

Plugin 'EinfachToll/DidYouMean'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'ajh17/Spacegray.vim.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'burnettk/vim-angular'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ciaranm/detectindent'
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'motemen/git-vim'
Plugin 'nvie/vim-flake8'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic.git'
Plugin 'squarefrog/tomorrow-night.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'vim-scripts/Gundo.git'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-scripts/vimwiki'

if v:version > 703
  Plugin 'SirVer/ultisnips'
  Plugin 'chrisbra/vim-diff-enhanced'
endif

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

set background=light
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

" Trim trailing whitespace in the file.
command TrimWhitespace %s/\s\+$//e

" Command to close current buffer without closing the window.
command Bd :bp | :sp | :bn | :bd

" Jade, the automatic import tool.
if (usegooglevim)
  command Jade !/google/data/ro/teams/jade/jade %
endif

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

" => Google plugins (see go/vim) ------------------------------------------ {{{1

if (usegooglevim)
  Glug blaze plugin[mappings]='<leader>b'
  Glug blazedeps
  Glug codefmt-google auto_filetypes+=blazebuild,java
  Glug corpweb
  Glug coverage
  Glug coverage-google
  Glug critique
  Glug ft-java
  Glug ft-javascript
  Glug ft-proto
  Glug ft-python
  Glug git5
  Glug google-filetypes
  Glug googlestyle
  Glug grok
  Glug gtimporter
  Glug languages
  Glug refactorer
  Glug relatedfiles
  Glug scampi
  Glug syntastic-google checkers[java]=`['glint']`
  Glug ultisnips-google
  Glug whitespace
  Glug youcompleteme-google

  " Enable Gtags (only works if project is not in //google3/experimental).
  " source /usr/share/vim/google/gtags.vim
  " nnoremap <Leader><C-]> :exe 'Gtlist ' . expand('<cword>')<cr>

  " Open relevant BUILD file.
  nnoremap <F10> :RelatedFilesWindow<cr>

  " Register Vigor.
  source /google/data/ro/projects/vigor/vigor.vim
endif

" => Plugins configuration ------------------------------------------------ {{{1

" NERDTree: auto close if last window.
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" NERDTree: ignore compiled files.
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Exuberant Ctags: autogenerate on file write.
augroup ctags
  autocmd!
  au BufWritePost *.py silent! !ctags -R * 2>/dev/null &
augroup END

" Force Gundo preview to the bottom.
let g:gundo_preview_bottom = 1

" Map Gundo.
nnoremap <F5> :GundoToggle<cr>

" DetectIndent: Enable and configure.
augroup detectindent
  autocmd!
  autocmd BufReadPost * :DetectIndent
augroup END
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

" Ignore line length errors.
let g:syntastic_python_flake8_args='--ignore=E501'

" UltiSnips: Compatibility with YouCompleteMe via SuperTab.
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" VimWiki: default location.
let g:vimwiki_list = [{
  \ 'path': '$HOME/Dropbox/wiki',
  \ 'template_path': '$HOME/Dropbox/wiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]

" Map Tagbar.
nnoremap <F8> :TagbarToggle<cr>

" Synastic configuration.
let g:syntastic_always_populate_loc_list = 1  " Make :lnext work.
let g:syntastic_html_checkers = ['']
let g:syntastic_javascript_checkers = ['gjslint', 'jshint']
let g:syntastic_javascript_gjslint_args = '--strict'
let g:syntastic_python_checkers = ['gpylint']
