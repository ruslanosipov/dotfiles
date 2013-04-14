"""""""""""""""""""""""""""""""""""""""
" => Pre-load
"""""""""""""""""""""""""""""""""""""""

" Pathogen: load and infect
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""

syntax on

" Indentation settings
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab

" Disable backups and .swp files
set nobackup
set nowritebackup
set noswapfile

" Ignore case when searching
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""
" => Looks
"""""""""""""""""""""""""""""""""""""""

set background=dark
colorscheme solarized

" Set terminal window title
set title
" And return it back on exit
let &titleold=getcwd()

" Shorten press ENTER to continue messages
set shortmess=atI

" Show last command
set showcmd

" Highlight cursor line
set cursorline

" Ruler (line, column and % at the right bottom)
set ruler

" Enable wild menu (tab command autocompletion)
set wildmenu
set wildmode=list:longest,full

" Display line numbers if terminal is wide enough
if &co > 80
  set nu
endif

"""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""

" Use Unix as the standart file type
set ffs=unix,dos,mac

" Enable filetype plugins
filetype plugin on
filetype indent on

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.pyo

"""""""""""""""""""""""""""""""""""""""
" => GVIM related fixes
"""""""""""""""""""""""""""""""""""""""

" Ignore mouse (in GVIM)
set mouse=c

" Fix backspace behavior
set bs=2

"""""""""""""""""""""""""""""""""""""""
" => Windows fixes
"""""""""""""""""""""""""""""""""""""""

if has("win32") || has("win64") || has("win32unix")
  let g:NERDTreeDirArrows=0
endif

"""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""

" EasyMotion: one leader key instead of two
let g:EasyMotion_leader_key = '<Leader>'

" NERDTree: auto open if terminal is wide enough
if !&diff && &co > 120
  autocmd VimEnter * NERDTree
endif

" NERDTree: close if only NERDTree left
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" NERDTree: focus on text window (left)
autocmd VimEnter * wincmd l
autocmd BufNew * wincmd l

" NERDTree: auto close if last window
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" Exuberant Ctags: autogenerate on py file write
au BufWritePost *.py silent! !ctags -R &

" Pydoc: open in new tab instead of split
let g:pydoc_open_cmd = 'tabnew'

" Pydoc: disable search term highlight
let g:pydoc_highlight=0 

"""""""""""""""""""""""""""""""""""""""
" => Shell command
"""""""""""""""""""""""""""""""""""""""

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)

function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  rightbelow new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction
