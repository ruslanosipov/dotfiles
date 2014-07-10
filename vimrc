" URL: https://github.com/ruslanosipov/dotfiles
" Author: Ruslan Osipov
" Description: Corporate .vimrc file. This is different from what is in a
" personal GitHub repository.

" => Pre-load ------------------------------------------------------------- {{{1

set nocompatible
filetype plugin on

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

source /usr/share/vim/google/core.vim

" => Editing -------------------------------------------------------------- {{{1

syntax on

" Indentation settings.
set autoindent
set expandtab
set shiftwidth=2
" set smartindent -- This brakes plaintext editing.
set tabstop=2

" Disable backups and .swp files.
set nobackup
set noswapfile
set nowritebackup

" Semicolon is too long to type.
nnoremap ; :

" Use system clipboard.
set clipboard=unnamedplus

" Enable wild menu (tab command autocompletion).
set wildmenu
set wildmode=list:longest,full

" => Looks ---------------------------------------------------------------- {{{1

set background=dark
colorscheme Tomorrow-Night

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
  set nu
endif

" Soft word wrap.
set linebreak

" => Movement and search -------------------------------------------------- {{{1

" Ignore case when searching.
set ignorecase
set smartcase

" Don't ignore case for file completion.
" set nofileignorecase

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
autocmd Filetype gitcommit setlocal spell textwidth = 72

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

" Solarized Mac compatibility.
if !has('gui_running')
  let g:solarized_termtrans = 1
  let g:solarized_termcolors = 16
endif

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight = 2
endif

" => Plugins -------------------------------------------------------------- {{{1

" EasyMotion: one leader key instead of two.
let g:EasyMotion_leader_key = '<Leader>'

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

" Exuberant Ctags: autogenerate on py file write.
au BufWritePost *.py silent! !ctags -R * &

" Pydoc: open in new tab instead of split.
let g:pydoc_open_cmd = 'tabnew'

" Pydoc: disable search term highlight.
let g:pydoc_highlight = 0 

" Map Gundo.
nnoremap <F5> :GundoToggle<CR>

" Force Gundo preview to the bottom.
let g:gundo_preview_bottom = 1

" SimpylFold: Do not fold docstrings.
let g:SimpylFold_fold_docstring = 0

" Synastic: Make :lnext work.
let g:syntastic_always_populate_loc_list = 1

" DetectIndent: Enable and configure.
:autocmd BufReadPost * :DetectIndent
:let g:detectindent_preferred_expandtab = 1
:let g:detectindent_preferred_indent = 2

" UltiSnips: Compatibility with YouCompleteMe via SuperTab.
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Map VimRoom.
nnoremap <Leader>vr :VimroomToggle<CR>

" => Google plugins ------------------------------------------------------- {{{1

Glug blaze do/mappings='<Leader>b'
Glug blazedeps
Glug codefmt auto_filetypes+=blazebuild
Glug google-filetypes
Glug relatedfiles
Glug syntastic-google
Glug ultisnips-google
Glug whitespace
Glug youcompleteme-google

let g:syntastic_python_checkers = ['gpylint']
let g:syntastic_javascript_gjslint_conf = '--strict'

autocmd BufWritePost *.py exe ":SyntasticCheck gpylint"

" Open relevant BUILD file.
nnoremap <F10> :RelatedFilesWindow<CR>
