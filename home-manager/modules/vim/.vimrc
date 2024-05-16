set nocompatible                  " this enables lots of good stuff
filetype off                      " required by Vundle

filetype plugin indent on         " required

set modeline                      " this is off in Ubuntu by default; f that
set t_Co=256                      " terminal has 256 colours
set bg=dark
set encoding=utf-8                " encoding is used for display purposes
set noerrorbells                  " shut up!
set ignorecase                    " ignore case when searching.  Prefix search with \c to match case
set smartcase                     " When search contains a capital letter, become case sensitive
set backspace=indent,eol,start    " allow backspacing over everything in INS mode
set whichwrap=<,>,[,],h,l,b,s,~   " Make end/beginning-of-line cursor wrapping behave human-like, not vi-like
set wrap                          " use wrapping
"set showbreak=---------->         " but emphasize when it occurs
set autoindent
set history=1000                  " keep lots of history of commands
set expandtab                     " spaces, not tabs
syntax enable                     " use syntax hilighting
colorscheme lunaperche
set ruler                  " always show cursor location in file
set showcmd                " show partially typed commands
set incsearch              " do incremental searching
set hls                    " highlight searches
set tabstop=2              " number of spaces that a <Tab> in the file counts for
set shiftwidth=2           " number of spaces to use for each step of autoindent
set hidden                 " allow switching buffers even if not saved
set showmatch              " match parentheses as you type them
"set foldmethod=syntax
set foldlevel=100          " Don't autofold anything
set nolist                   " show normally hidden characters
hi SpecialKey guifg=darkgray  " make the listchars characters show up dark gray
"hi CursorLine term=bold cterm=bold guibg=Grey40 " highlight lines for visual
set listchars=tab:>\\,trail:·,extends:#,nbsp:.
set list
set wildmenu               " Wild!  This thing kicks ass.
set wildmode=longest,full  " First match only to the longest common string, then use full/wildmenu match
set wildignore=*.o,*.pyc,*.class
set laststatus=2           " Always show status line
"set statusline=%<%f\ %y[%{&ff}]%m%r%w%a\ %=%l/%L,%c%V\ %P  " cooler status line
set nosol                  " don't jump to the start of the line on a bunch of different movement commands
set complete-=i           " from vim-sensible, blind copy/paste
set guioptions-=t         " No tear-off menus
set guioptions-=T         " No toolbar
set guioptions-=m         " No top menu
set guioptions-=r         " No right scrollbar
set guioptions-=R         " No right scrollbar in splits
set guioptions-=l         " No left srollbar
set guioptions-=L         " No left srollbar in vertical splits
set guioptions-=b         " No bottom scrollbar
set guioptions-=e         " Use textmode tabs even in gvim
set guitablabel=\[%N\]\ %t\ %M " Display tab number and filename in tab
set tags=./tags;/         " tags=.tags;/ <-- searches parent dirs for tags files
"set autochdir             " change working dir to be the location of the current file
let mapleader = ","
let maplocalleader = "\\"
set formatoptions+=l      " Don't break and auto-format long lines.
set formatoptions-=t      " Don't autoformat shit
set number                " line nums
set updatetime=300        " after this many ms the swap file is written (default 4000)
set signcolumn=yes        " always show the extra column on the left to avoid text shifting around
set shortmess+=c          " don't add noisy status messages to completion popup

augroup STATUSLINE
  set statusline=
  set statusline+=%#PmenuSel#
  set statusline+=%#LineNr#
  set statusline+=\ %f
  set statusline+=%m\ 
  set statusline+=%=
  set statusline+=%#CursorColumn#
  set statusline+=\ %y
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
  set statusline+=\[%{&fileformat}\]
  set statusline+=\ %p%%
  set statusline+=\ %l:%c
  set statusline+=\ 
augroup END

augroup FZF
  " :Files from fzf
  nnoremap <leader>f :Files<CR>
  " e because ctrl-e was recent files in IntelliJ
  nnoremap <leader>e :History<CR>
  nnoremap <leader>r :Rg <C-R><C-W><CR>
  " add ctrl-q to fzf (for populating quickfix list with selected results)
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction
  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit' }
  " Delegate fzf's ':Rg' to ripgrip directly
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  " override the :Rg that comes with fzf-vim
  command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

  " remove the annoying :Windows command I always accidentally trigger
  silent! delcommand Windows
augroup END

"##############################################################################
" Mappings
"##############################################################################

" .vimrc editing
nnoremap <leader>ev :split $MYVIMRC<CR>

" set some mappings to easly cycle through buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" a handy mapping to fix tabs and kill trailing whitespace
" rt -> re-tab
" nnoremap <leader>rt m`:retab<CR>:%s/\s\+$//eg<CR>``

" a mapping to refresh the syntax colouring easily -- this is really only
" useful when writing syntax files.
nnoremap <F12> :syn sync fromstart<CR>

" open definitions in a split
" (don't use `nore` variant; we want recursive mapping on these since they're
" often mapped by other plugins)
nmap <leader>gd :split<CR>gd
nmap <leader>gD :split<CR>gD

"##############################################################################
" Easier split navigation
"##############################################################################

" Use ctrl-[hjkl] to select the active split! (http://www.vim.org/tips/tip.php?tip_id=173)
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" faster splits and tabs
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>c :close<CR>
nnoremap <leader>C :bd!<CR>
nnoremap <leader>o :only<CR>
" open current split in new tab
nnoremap <leader>t <C-W>T

" jump between hunks (gitgutter)
"nnoremap ]h <Plug>(GitGutterNextHunk)
"nnoremap [h <Plug>(GitGutterPrevHunk)

" Stuff stolen from vim-sensible: https://github.com/tpope/vim-sensible
set viminfo^=!

"##############################################################################
" Functions
"
"   syntax: "function!" causes a function to be replaced if it exists already
"##############################################################################

" Hit space to remove highlighting
nmap <Space> :noh<CR>

" Check if file changed underneath us
" http://stackoverflow.com/a/927634/69689
au CursorHold * if getcmdtype() == '' | checktime | endif

" Make Python follow PEP8 (http://www.python.org/dev/peps/pep-0008/)
au Filetype python setlocal ts=4 sw=4 sts=4 tw=79

au Filetype scala setlocal foldmethod=indent tw=80 formatoptions+=l

au Filetype markdown setlocal foldlevel=100

" Run a command on the current file and put result in a new buffer in a new
" split:
" :new | r ! hg annotate -ud #

augroup clojure
  " vim-fireplace clojure mappings
  au FileType clojure map <localleader>e :w<CR>:Eval<CR>
  au FileType clojure map <localleader>q :w<CR>:Require<CR>
  au FileType clojure map <localleader>Q :w<CR>:Require!<CR>
  au FileType clojure map <localleader>c :CheckNs<CR>
  au FileType clojure set lispwords+=context,GET,POST,PUT,DELETE
augroup END

au FileType gitcommit set spell
" Assume postgres
let g:sql_type_default = 'pgsql'
"au BufNewFile,BufRead *.sql setf pgsql

" Abbreviations
ia becuase because
ia Becuase Because

let g:GPGDefaultRecipients = ['mark.feeney@gmail.com']

augroup golang
  " go, vim-go config (mostly from https://github.com/fatih/vim-go-tutorial)
  au!
  au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  au FileType go setlocal nolist
  au FileType go nmap <buffer> <localleader>i <Plug>(go-info)
  au FileType go nmap <buffer> gr :GoReferrers<CR>
  let g:go_fmt_command = "goimports"
  let g:go_highlight_extra_types = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
  "let g:go_auto_type_info = 1
  "let g:go_auto_sameids = 1
augroup END

" Use rg for :grep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" like :grep, but open quickfix unconditionally and don't focus it (use
" vim-unimparied to move between entries)
command! -nargs=+ -bar Grep silent! grep!  <args>|copen|wincmd p|redraw!
" grep for word under cursor and open in quickfix (mnemonic: 'all files')
nmap <leader>a :execute ":Grep '\\b" . expand("<cword>") . "\\b'"<CR>

augroup rust
  au!
  au Filetype rust nnoremap <F5> !cargo run<CR>
augroup END

augroup conf
  au!
  au BufNewFile,BufRead *.conf setlocal ft=conf
augroup END

augroup JSX
  let g:jsx_ext_required = 0
augroup END

augroup ALE
  nnoremap <leader>l :w<CR>:ALELint<CR>
  nnoremap <leader>L :ALEReset<CR>
  let g:ale_completion_enabled = 1
  let g:ale_pattern_options_enabled = 1
  let g:ale_fix_on_save = 1
  let g:ale_lint_on_save = 1
  let g:ale_fixers = {
    \'python': ['black'],
    \'nix': ['nixfmt'],
  \}
  let g:ale_sign_column_always = 1
  "au FileType javascriptreact nnoremap <buffer> <localleader>i :ALEHover<CR>
  "au FileType javascriptreact nnoremap <buffer> gd :ALEGoToDefinition<CR>
  "au FileType javascriptreact nnoremap <buffer> gr :ALEFindReferences -relative<CR>
augroup END

"set clipboard=unnamed " TODO: if non-empty, may break visual mode hilighting on mac... wtf!
set clipboard=

" remove the annoying :Windows command I always accidentally trigger
silent! delcommand Windows
