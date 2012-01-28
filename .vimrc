"""" to start vim in full-screen in windows, call it like this:
"""" c:\path\to\vim\gvim.exe -c "simalt ~x" "%1"
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
set nocompatible                  " this enables lots of good stuff
set bg=dark
set encoding=utf-8                " encoding is used for display purposes
set noerrorbells                  " shut up!
set ignorecase                    " ignore case when searching.  Prefix search with \c to match case
set smartcase                     " When search contains a capital letter, become case sensitive
set backspace=indent,eol,start    " allow backspacing over everything in INS mode
set whichwrap=<,>,[,],h,l,b,s,~   " Make end/beginning-of-line cursor wrapping behave human-like, not vi-like
set wrap                          " use wrapping
set showbreak=---------->         " but emphasize when it occurs
set autoindent
set history=256                   " keep lots of history of commands
set nobackup                      " I'm tired of all these backup files...
set expandtab                     " I'm also tired of screwed up tabstops, so no more tab -- spaces instead
set guioptions+=b                 " add a bottom scrollbar
syntax enable                     " use syntax hilighting
if !has("gui_running")
  " use this scheme in text vim
  colorscheme ps_color
else
  " use this scheme in gui vim
  colorscheme deveiate
endif
"set guifont=Envy\ Code\ R:11:cDEFAULT,ProFontWindows:h10:cANSI,Lucida_Console:h10:cANSI,Courier_New:h10:cANSI
set guifont=Envy\ Code\ R
set ruler                  " always show cursor location in file
set showcmd                " show partially typed commands
set incsearch              " do incremental searching
set hls                    " highlight searches
set tabstop=2              " number of spaces that a <Tab> in the file counts for
set shiftwidth=2           " number of spaces to use for each step of autoindent
set hidden                 " allow switching buffers even if not saved
set showmatch              " match parentheses as you type them
set foldmethod=manual      " I like to define my own folds usually
set foldlevelstart=99      " start with folds all open (99 levels anyway)
"set listchars=tab:»·,trail:·,extends:…  " make the hidden characters look nicer
"set list                 " show normally hidden characters
hi SpecialKey guifg=darkgray  " make the listchars characters show up dark gray
set wildmenu               " Wild!  This thing kicks ass.
set wildmode=longest,full  " First match only to the longest common string, then use full/wildmenu match
set laststatus=2           " Always show status bar
set statusline=%<%f\ %y[%{&ff}]%m%r%w%a\ %=%l/%L,%c%V\ %P  " cooler status line
set nosol                  " don't jump to the start of the line on a bunch of different movement commands
set complete=.,w,b,u,U,i,d,k,t  " Better auto completion, full tags last
set guioptions-=tT         " Don't show the toolbar icons or those damn tear-off menus
set grepprg=grep\ -EHns    " (E-extended regex, H-print file names, n-print line numbers, s-supress error messages) See: http://unxutils.sourceforge.net/
set viminfo='20,\"50,:256
set tags=./tags,tags,~/dev/jdk_tags,~/dev/scala_tags,~/dev/lift_tags,~/dev/poc/tags

if has("unix")
  set shellcmdflag=-ic
endif

let mapleader = ","

"##############################################################################
" Mappings
"##############################################################################

" set some mappings to easly cycle through buffers
noremap <C-Tab> :bnext<CR>
inoremap <C-Tab> <Esc>:bnext<CR>
cnoremap <C-Tab> :bnext<CR>

noremap <C-S-Tab> :bprev<CR>
inoremap <C-S-Tab> <Esc>:bprev<CR>
cnoremap <C-S-Tab> :bprev<CR>

" Allow toggling of folding (handy to get rid of foldcolumn if it's taking up
" too much space.
map <F4> :call <SID>ToggleFolding()<CR>
imap <F4> <Esc>:call <SID>ToggleFolding()<CR>a

" mappings for compiler-related stuff
map <F5> :make<CR>
"map <F8> :cw<CR>

" a handy mapping to fix tabs and kill trailing whitespace
map <F11> m`:retab<CR>:%s/\s\+$//eg<CR>``

" a mapping to refresh the syntax colouring easily -- this is really only
" useful when writing syntax files.
map <F12> :syn sync fromstart<CR>

nmap <silent> <kPlus> <Esc>:call <SID>IncrFoldLevel()<CR>
nmap <silent> <kMinus> <Esc>:call <SID>DecrFoldLevel()<CR>

"##############################################################################
" Easier split navigation
"##############################################################################

" Use ctrl-[hjkl] to select the active split! (http://www.vim.org/tips/tip.php?tip_id=173)
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" faster splits
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>c :close<CR>

"##############################################################################
" XML editing (http://www.pinkjuice.com/howto/vimxml/index.xml)
"##############################################################################
let g:xml_syntax_folding = 1

"##############################################################################
" Haskell (http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/)
"##############################################################################

" highlight something in visaul mode, then use the following combos to
" surround the highlighted area with brackets, parentheses, quotes, etc.
map <Leader>{ c{}P
map <Leader>( c()P
map <Leader>[ c[]P
map <Leader>" c""P
map <Leader>' c''P

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

"##############################################################################
" Functions
"
"   syntax: "function!" causes a function to be replaced if it exists already
"##############################################################################
" Enables/Disables folding (compliments: http://www.hut.fi/~tsusi/vim/dot.vimrc)
function! <SID>ToggleFolding()
    if &foldcolumn == 0
        setlocal foldenable
        setlocal foldcolumn=5
    else
        setlocal nofoldenable
        setlocal foldcolumn=0
    endif
endfunction

function! <SID>IncrFoldLevel()
    " we start at a high foldlevel usually -- like 99; then wrap to 0 if
    " exceeded
    if &foldlevel >= &foldlevelstart
        set foldlevel=0
    else
        let s:new_foldlevel=(&foldlevel + 1)
        let &foldlevel=s:new_foldlevel
    endif
endfunction

function! <SID>DecrFoldLevel()
    if &foldlevel > 0
        let s:new_foldlevel=(&foldlevel - 1)
        let &foldlevel=s:new_foldlevel
    endif
endfunction

" Hit <CR> to highlight the current word without moving the screen.  n/N works
" to jump between matches. http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
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
nnoremap <silent> <expr> <CR> Highlighting()

" Hit space to remove highlighting
nmap <Space> :noh<CR>

let vimclojure#HighlightBuiltins = 1
"let vimclojure#WantNailgun = 1

