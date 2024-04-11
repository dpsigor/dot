set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set smarttab
set si
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
filetype plugin on
syntax on                   " syntax highlighting
set mouse=
" set clipboard=unnamedplus   " using system clipboard
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
set nobackup
set nowb
set history=500
set autoread
let mapleader = " "
set so=7
set wildmenu
set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set smartcase
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1
set encoding=utf8
set nowrap
set laststatus=2
set splitbelow
set splitright
set viminfo='20,<1000,s1000
set signcolumn=number

let $RC="$HOME/.config/nvim/init.lua"
map <leader>e :e! $RC<CR>

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

nmap <leader>w :w!<CR>
map <leader>q :q<CR>
map <silent> <leader><cr> :noh<cr>
map 0 ^

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

vmap < <gv
vmap > >gv

map Y y$

inoremap <left> ``<left>
nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap N Nzz

inoremap <C-p> <C-r>"

vnoremap p "_dP

nnoremap <leader>vt :vs term://bash<CR>i
nnoremap <leader>vs :sp term://bash<CR>i

tnoremap <C-n> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

let g:UltiSnipsExpandTrigger="<tab>"
