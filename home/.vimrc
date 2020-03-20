set nocompatible                  " this enables lots of good stuff
filetype off                      " required by Vundle

set rtp+=/usr/local/opt/fzf
let g:ale_completion_enabled = 1

" Use Vundle to manage plugins: https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()                "required
" Vundle needs to manage itself
Plugin 'VundleVim/Vundle.vim'

Plugin 'derekwyatt/vim-scala'
Plugin 'plasticboy/vim-markdown'
Plugin 'overthink/vim-matchit'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-fireplace'
Plugin 'overthink/vim-classpath'
Plugin 'guns/vim-clojure-static'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'sickill/vim-monokai'
Plugin 'tomasr/molokai'
Plugin 'krisajenkins/vim-pipe'
Plugin 'rust-lang/rust.vim'
Plugin 'exu/pgsql.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'overthink/nginx-vim-syntax'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-unimpaired'
Plugin 'fatih/vim-go'
Plugin 'jamessan/vim-gnupg'
Plugin 'cespare/vim-toml'
Plugin 'rodjek/vim-puppet'
Plugin 'ajh17/VimCompletesMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'

call vundle#end()                 " required
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
colorscheme molokai
set ruler                  " always show cursor location in file
set showcmd                " show partially typed commands
set incsearch              " do incremental searching
set hls                    " highlight searches
set tabstop=2              " number of spaces that a <Tab> in the file counts for
set shiftwidth=2           " number of spaces to use for each step of autoindent
set hidden                 " allow switching buffers even if not saved
set showmatch              " match parentheses as you type them
set foldmethod=syntax
set foldlevel=100          " Don't autofold anything
set nolist                   " show normally hidden characters
hi SpecialKey guifg=darkgray  " make the listchars characters show up dark gray
"hi CursorLine term=bold cterm=bold guibg=Grey40 " highlight lines for visual
set listchars=tab:>\\,trail:·,extends:#,nbsp:.
set list
set wildmenu               " Wild!  This thing kicks ass.
set wildmode=longest,full  " First match only to the longest common string, then use full/wildmenu match
set wildignore=*.o,*.pyc,*.class
set laststatus=2           " Always show status bar
set statusline=%<%f\ %y[%{&ff}]%m%r%w%a\ %=%l/%L,%c%V\ %P  " cooler status line
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

let g:airline_theme='dark'

"##############################################################################
" Mappings
"##############################################################################

" .vimrc editing
nnoremap <leader>ev :split $MYVIMRC<cr>

" set some mappings to easly cycle through buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" a handy mapping to fix tabs and kill trailing whitespace
" rt -> re-tab
nnoremap <leader>rt m`:retab<CR>:%s/\s\+$//eg<CR>``

" a mapping to refresh the syntax colouring easily -- this is really only
" useful when writing syntax files.
nnoremap <F12> :syn sync fromstart<CR>

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

nnoremap <leader>f :Files<CR>

" Stuff stolen from vim-sensible: https://github.com/tpope/vim-sensible
set viminfo^=!

" Dirs not created automatically: mkdir -p ~/.local/share/vim/{swap,backup,undo}
let s:dir = has('win32') ? '~/Application Data/Vim' : has('mac') ? '~/Library/Vim' : '~/.local/share/vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif

"##############################################################################
" Functions
"
"   syntax: "function!" causes a function to be replaced if it exists already
"##############################################################################

" Ripped from https://github.com/mkitt/tabline.vim
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()

" Hit <s-CR> (used to use <CR>, but screws up use of quickfix window) to
" highlight the current word without moving the screen.  n/N works to jump
" between matches.
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <s-CR> Highlighting()

" Hit space to remove highlighting
nmap <Space> :noh<CR>

" Check if file changed underneath us
" http://stackoverflow.com/a/927634/69689
au CursorHold * if getcmdtype() == '' | checktime | endif

" Make Python follow PEP8 (http://www.python.org/dev/peps/pep-0008/)
au Filetype python setlocal ts=4 sw=4 sts=4 tw=79

au Filetype scala setlocal foldmethod=indent tw=80 formatoptions+=l

au Filetype markdown setlocal foldlevel=100
au FileType markdown let b:vimpipe_command="multimarkdown | lynx -dump -stdin"

" Run a command on the current file and put result in a new buffer in a new
" split:
" :new | r ! hg annotate -ud #


" vim-fireplace clojure mappings
au FileType clojure map <localleader>e :w<CR>:Eval<CR>
au FileType clojure map <localleader>q :w<CR>:Require<CR>
au FileType clojure map <localleader>Q :w<CR>:Require!<CR>
au FileType clojure map <localleader>c :CheckNs<CR>
au FileType clojure map <localleader>t :TypeAt<CR>

au FileType gitcommit set spell

" Assume postgres
let g:sql_type_default = 'pgsql'
"au BufNewFile,BufRead *.sql setf pgsql

au FileType clojure set lispwords+=context,GET,POST,PUT,DELETE

" Abbreviations
ia becuase because
ia Becuase Because

let g:GPGDefaultRecipients = ['mark.feeney@gmail.com']

" go, vim-go config (mostly from https://github.com/fatih/vim-go-tutorial)
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
au FileType go setlocal nolist
au FileType go nmap <localleader>i <Plug>(go-info)
au FileType go nmap gr :GoReferrers<CR>
let g:go_fmt_command = "goimports"
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" prefer grepping with ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

autocmd Filetype rust nnoremap <F5> !cargo run<CR>

autocmd BufNewFile,BufRead *.conf setlocal ft=conf

let g:github_enterprise_urls = ['https://git.corp.stripe.com']

augroup ALE
  nnoremap <leader>l :w<CR>:ALELint<cr>
  nnoremap <leader>L :ALEReset<cr>
  let g:ale_pattern_options = {
\ 'pay-server/.*\.rb$': { 'ale_ruby_rubocop_executable': 'scripts/bin/rubocop-daemon/rubocop' },
\}
  let g:ale_ruby_rubocop_executable = 'bundle'
  let g:ale_fixers = {}
  let g:ale_fixers['javascript'] = ['prettier', 'eslint']
  let g:ale_sign_column_always = 1
augroup END

augroup VimAirline
  au!
  let g:airline_powerline_fonts = 1
  let g:airline_theme='base16_twilight'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
augroup END

"set clipboard= " TODO: if non-empty, breaks visual mode hilighting on mac... wtf!
set clipboard=unnamed
