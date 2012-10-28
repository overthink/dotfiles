set nocompatible                  " this enables lots of good stuff
filetype off                      " required by Vundle

" Use Vundle to manage plugins: https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Vundle needs to manage itself
Bundle 'gmarik/vundle'

Bundle 'derekwyatt/vim-scala'
Bundle 'plasticboy/vim-markdown'
Bundle 'majutsushi/tagbar'
Bundle 'tsaleh/vim-matchit'

Bundle 'overthink/vimclojure'
let vimclojure#WantNailgun = 1
Bundle 'vim-scripts/paredit.vim'

Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'

Bundle 'ervandew/supertab'
let g:superTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = 'context'

Bundle 'flazz/vim-colorschemes'

filetype plugin indent on         " required

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
set history=256                   " keep lots of history of commands
set nobackup                      " I'm tired of all these backup files...
set expandtab                     " I'm also tired of screwed up tabstops, so no more tab -- spaces instead
syntax enable                     " use syntax hilighting
if !has("gui_running")
  colorscheme ps_color
else
  colorscheme deveiate
  "colorscheme jellybeans
endif
"set guifont=Envy\ Code\ R:11:cDEFAULT,ProFontWindows:h10:cANSI,Lucida_Console:h10:cANSI,Courier_New:h10:cANSI
set guifont=Envy\ Code\ R
"set guifont=ProFont\ 11
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
"set listchars=tab:»·,trail:·,extends:…  " make the hidden characters look nicer
set nolist                   " show normally hidden characters
hi SpecialKey guifg=darkgray  " make the listchars characters show up dark gray
set wildmenu               " Wild!  This thing kicks ass.
set wildmode=longest,full  " First match only to the longest common string, then use full/wildmenu match
set wildignore=*.o,*.pyc,*.class
set laststatus=2           " Always show status bar
set statusline=%<%f\ %y[%{&ff}]%m%r%w%a\ %=%l/%L,%c%V\ %P  " cooler status line
set nosol                  " don't jump to the start of the line on a bunch of different movement commands
set complete=.,w,b,u,U,i,d,k,t  " Better auto completion, full tags last
set guioptions-=t         " No tear-off menus
set guioptions-=T         " No toolbar
set guioptions-=m         " No top menu
set guioptions-=r         " No right scrollbar
set guioptions-=R         " No right scrollbar in splits
set guioptions-=l         " No left srollbar
set guioptions-=L         " No left srollbar in vertical splits
set guioptions-=b         " No bottom scrollbar
"set grepprg=grep\ -EHns   " (E-extended regex, H-print file names, n-print line numbers, s-supress error messages) See: http://unxutils.sourceforge.net/
set grepprg=ack-grep\ --column
set grepformat=%f:%l:%c:%m
set viminfo='20,\"50,:256
set tags=./tags;/         " tags=.tags;/ <-- searches parent dirs for tags files
set tags+=~/dev/jdk_tags,~/dev/scala_tags,~/dev/lift_tags  
set autochdir             " change working dir to be the location of the current file
let mapleader = ","

"##############################################################################
" Mappings
"##############################################################################

" Alt-] to open a tag in a new split
map <A-]> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" set some mappings to easly cycle through buffers
noremap <C-Tab> :bnext<CR>
inoremap <C-Tab> <Esc>:bnext<CR>
cnoremap <C-Tab> :bnext<CR>

noremap <C-S-Tab> :bprev<CR>
inoremap <C-S-Tab> <Esc>:bprev<CR>
cnoremap <C-S-Tab> :bprev<CR>

" a handy mapping to fix tabs and kill trailing whitespace
map <F11> m`:retab<CR>:%s/\s\+$//eg<CR>``

" a mapping to refresh the syntax colouring easily -- this is really only
" useful when writing syntax files.
map <F12> :syn sync fromstart<CR>

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

" Make Python follow PEP8 (http://www.python.org/dev/peps/pep-0008/)
autocmd Filetype python setlocal ts=4 sw=4 sts=4 tw=79

autocmd Filetype scala setlocal foldmethod=indent

" Run a command on the current file and put result in a new buffer in a new
" split:
" :new | r ! hg annotate -ud #

