"----------------------
" Vimrc dot file
"
" Sections:
"    Plugin Management
"    Basics Vim Startup
"    UI Tweaks
"    Vim Functionality
"    Text Handling
"    Mappings
"----------------------

"------------------
" Plugin Management
"------------------
    set nocompatible " Overrides the -C option (more vim like less vi like)
    filetype off " Vundle required
    set rtp+=~/.vim/bundle/Vundle.vim " Set Vundle runtime path
    call vundle#begin() " Initialize Vundle

    " Plugin calls
    Plugin 'VundleVim/Vundle.vim' " Let Vundle manage Vundle
    Plugin 'tpope/vim-fugitive' " Plugin for git
    Plugin 'ctrlpvim/ctrlp.vim' " CtrlP fuzzy finder
    Plugin 'MarcWeber/vim-addon-mw-utils' " SnipMate dependency
    Plugin 'tomtom/tlib_vim' " SnipMate dependency
    Plugin 'garbas/vim-snipmate' " SnipMate plugin
    Plugin 'honza/vim-snippets' " Snippets
    Plugin 'scrooloose/nerdtree' " NerdTree
    Plugin 'vim-airline/vim-airline-themes' " Powerline for vim
    Plugin 'vim-airline/vim-airline' " Powerline for vim
    Plugin 'sophacles/vim-processing.git' " Add processing functionality
    Plugin 'dsfcode/hive.vim.git' " Add hive syntax
    let g:airline_theme='papercolor'

    call vundle#end() | filetype plugin indent on " End plugin management

"------------------
" Basic Vim Startup
"------------------
    syntax on " Turn syntax on
    colorscheme delek " Set the colorscheme
    set history=1000 " Bigger history than default
    set ffs=unix,mac,dos " Use Unix as the standard file type
    set noswapfile | set nowritebackup | set nobackup " Make vim run faster by turning off swap files/backup

"----------
" UI Tweaks
"----------
    set number " Set line numbers to visible
    set numberwidth=5 " Set default line number width
    set wildmenu " Better command-line completion
    set laststatus=2 " Always display the status line
    set showcmd " Use to view last command and also number of line/chars highlighted
    set statusline=%M\ %F\ %=[%{&ff},%{&ft}]\ [(%l,%v)/%L\ %p%%] " Set what is displayed on the status line
    set nohls " Don't highlight when searching

"------------------
" Vim Functionality
"------------------
    set hidden " Makes working with buffers easier
    set splitright " Default :sp to split to the right
    set tabpagemax=20 " Set the max number of tabs you can have open at once (default is 10)
    set whichwrap=<,>,[,],b,s " Use cursors, space, and backspace to wrap
    set ignorecase | set smartcase " Use case insensitive search, except when using capital letters (smartcase)
    set confirm " Ask to save file if quitting with unsaved files open
    set autoread " Set to auto read when a file is changed from the outside
    set lazyredraw " Don't redraw while executing macros (good performance config)
    set nomore " Finish more output right away
    set helpheight=10 " Set help file height (default 20)
    set timeoutlen=50 " Wait less on multiple key commands

"--------------
" Text Handling
"--------------
    set autoindent " Enable auto indent
    set iskeyword-=_ " Make _ a word devider
    set magic " For regular expressions turn magic on
    set tabstop=8 | set expandtab | set shiftwidth=4 | set softtabstop=4 " Set up tab execution (python style)
    set nofoldenable " Don't automatically fold
    set foldmethod=manual " Use indents for folding
    autocmd BufEnter * if &filetype == "text" | setlocal ft=conf | endif " Syntax highlight text files like they are conf files
    autocmd BufEnter * setlocal formatoptions-=cro " Stop vim from creating automatic comments, see :help fo-table for specifics

"---------
" Mappings
"---------
    " Treat long lines as break lines (useful when moving around in them)
    nmap j gj
    nmap k gk

    " Move a line of text using CTRL+[JK]
    nmap <c-J> ddp
    nmap <c-K> ddkP

    " Use Ctrl-n to toggle line numbers
    nmap <c-n> :set invnumber<CR>
    imap <c-n> <Esc>:set invnumber<CR>a

    " Put ${ } around a word (good for dealing with bash variables)
    imap <c-a> <Esc>bi${<Esc>ea}

    " Use F12 (func F12 on mac) to toggle paste mode
    nmap <F12> :set invpaste<CR>
    imap <F12> <Esc>:set invpaste<CR>a
    set pastetoggle=<F12>

    " Use control keys to get around in tabs
    nmap <c-l> gt
    nmap <c-h> gT

    " Use w and movement keys at the same time to move around windows
    nmap wj <C-W><C-J> | nmap jw <C-W><C-J>
    nmap wk <C-W><C-K> | nmap kw <C-W><C-K>
    nmap wl <C-W><C-L> | nmap lw <C-W><C-L>
    nmap wh <C-W><C-H> | nmap hw <C-W><C-H>

    " Map jk and kj to Esc
    imap jk <Esc> | imap kj <Esc>

    " Switch two blocks of text
    vnoremap <c-x> <Esc>`.``gvP``P

    " Yank an entire file
    nmap <c-c> ggyG``

    " Command for bash tab mapping
    command Bashtabs :set tabstop=4 | set shiftwidth=4 | set noexpandtab

    " Command for bash tab mapping
    command Pythontabs :set tabstop=8 | set expandtab | set shiftwidth=4 | set softtabstop=4

