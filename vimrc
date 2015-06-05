" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Corporate .vimrc file. This is different from what is in a
" personal GitHub repository.

" => Pre-load ------------------------------------------------------------- {{{1

set nocompatible
filetype plugin indent on

" Required Vundle setup.
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" Load core Google plugins.
source /usr/share/vim/google/core.vim

" => Vundle plugins ------------------------------------------------------- {{{1

Plugin 'gmarik/vundle'

Plugin 'EinfachToll/DidYouMean'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'SirVer/ultisnips'
Plugin 'ajh17/Spacegray.vim.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'burnettk/vim-angular'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ciaranm/detectindent'
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/rope-vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'motemen/git-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rosenfeld/conque-term'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic.git'
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
Plugin 'NLKNguyen/papercolor-theme'

" => Editing -------------------------------------------------------------- {{{1

syntax on

" Indentation settings.
set autoindent
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

" Map leader to a comma.
let mapleader = "\<Space>"

" Use system clipboard.
set clipboard=unnamedplus

" Enable wild menu (tab command autocompletion).
set wildmenu
set wildmode=list:longest,full

command TrimWhitespace %s/\s\+$//e

" This needs to be worked on. Messes up the code. Probably set for .wiki or
" .txt formats only. Not for Python code, that's for sure.
" augroup prose
"     autocmd InsertEnter * set formatoptions+=a
"     autocmd InsertLeave * set formatoptions-=a
" augroup END

" Command to close current buffer without closing the window.
command Bd :bp | :sp | :bn | :bd

" Don't complain about unsaved files when switching buffers.
set hidden

" => Leader shortcuts ----------------------------------------------------- {{{1

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>r :redraw!<CR>

" => Looks ---------------------------------------------------------------- {{{1

set background=light
colorscheme PaperColor

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
  " set relativenumber
endif

" Soft word wrap.
set linebreak

" Prettier display of long lines of text.
set display+=lastline

" Powerline.
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline.
set laststatus=2

" => Movement and search -------------------------------------------------- {{{1

" Ignore case when searching.
set ignorecase
set smartcase

" Fast split navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" Temporary: disable folds on opening file.
autocmd BufRead * normal zR

" => Fixes and hacks ------------------------------------------------------ {{{1

" Ignore mouse (in GVIM).
set mouse=c

" Fix backspace behavior in GVIM.
set bs=2

" NERDTree arrows in Windows.
if has("win32") || has("win64") || has("win32unix")
  let g:NERDTreeDirArrows = 0
endif

" Solarized Mac compatibility.
if has('gui_running')
  set guioptions=
  set guifont=M+\ 1mn\ Regular\ 14
  set g:airline_symbols_space="\ua0"
endif

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
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

" NERDTree: toggle.
nnoremap <leader>nt :NERDTreeToggle<cr>

" Exuberant Ctags: autogenerate on py file write.
augroup ctags
  autocmd!
  au BufWritePost */git/google3/**/*.py silent! !ctags -R * &
augroup END

" Pydoc: open in new tab instead of split.
let g:pydoc_open_cmd = 'tabnew'

" Pydoc: disable search term highlight.
let g:pydoc_highlight = 0

" Map Gundo.
nnoremap <F5> :GundoToggle<cr>

" Force Gundo preview to the bottom.
let g:gundo_preview_bottom = 1

" Synastic: Make :lnext work.
let g:syntastic_always_populate_loc_list = 1

" DetectIndent: Enable and configure.
augroup detectindent
  autocmd!
  autocmd BufReadPost * :DetectIndent
augroup END
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

" UltiSnips: Compatibility with YouCompleteMe via SuperTab.
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ConqueTerm: Ignore warnings.
let g:ConqueTerm_StartMessages = 0

" VimWiki: default location.
let g:vimwiki_list = [{
  \ 'path': '$HOME/Dropbox/wiki',
  \ 'template_path': '$HOME/Dropbox/wiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]

" Map Tagbar.
nmap <F8> :TagbarToggle<CR>

" => Google plugins ------------------------------------------------------- {{{1

Glug blaze plugin[mappings]='<leader>b'
Glug blazedeps
Glug codefmt-google auto_filetypes+=blazebuild,java
Glug corpweb
Glug critique
Glug ft-javascript
Glug ft-java
Glug ft-python
Glug ft-proto
Glug git5
Glug gtimporter
Glug google-filetypes
Glug googlestyle
Glug languages
Glug refactorer
Glug relatedfiles
Glug syntastic-google checkers[java]=`['glint']`
Glug ultisnips-google
Glug whitespace
Glug youcompleteme-google
Glug scampi

let g:syntastic_html_checkers = ['']
let g:syntastic_javascript_checkers = ['gjslint', 'jshint']
let g:syntastic_javascript_gjslint_conf = '--strict'
let g:syntastic_python_checkers = ['gpylint']

" augroup syntastic_pylint
"   autocmd!
"   autocmd BufWritePost *.py exe ":SyntasticCheck gpylint"
" augroup END

" Open relevant BUILD file.
nnoremap <F10> :RelatedFilesWindow<cr>

" Unfold all files by default.
au BufRead * normal zR

command Jade !/google/data/ro/teams/jade/jade %

" Register Vigor and let it work in //experimental.
source /google/data/ro/projects/vigor/vigor.vim
let g:vig_source_paths = ['java',
                         \ '../READONLY/google3/java',
                         \ 'experimental',
                         \ '../READONLY/google3/experimental',
                         \ 'blaze-genfiles/experimental',
                         \ 'javatests',
                         \ '../READONLY/google3/javatests',
                         \ 'blaze-genfiles/java']

" Enable Gtags.
source /usr/share/vim/google/gtags.vim
