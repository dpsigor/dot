" set number relativenumber
set number
set visualbell

set fileformat=unix
set fileformats=unix

set colorcolumn=160

let &t_SI = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Para subir e descer linhas, nos três modos
nmap <silent> <C-j> :m .+1<CR>==
nmap <silent> <C-k> :m .-2<CR>==
imap <silent> <C-j> <Esc>:m .+1<CR>==gi
imap <silent> <C-k> <Esc>:m .-2<CR>==gi
vmap <silent> <C-j> :m '>+1<CR>gv=gv
vmap <silent> <C-k> :m '<-2<CR>gv=gv

" Para substituir a palavra sob o curso
nnoremap <leader>s *<S-n>cgn

" Emojis

ab :checked: ✅
ab :failed: 🚫
ab :warning: ⚠️
ab :pushpin: 📌
ab :bomb: 💣
ab :construction: 🚧
ab :point_right: 👉
ab :joia: 👍
ab :pray: 🙏
ab :brain: 🧠
ab :poo: 💩

" netrw
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_banner = 0

set splitbelow splitright

" Usar variável para abrir este rc com facilidade
let $RC="$HOME/.vim_runtime/my_configs.vim"
map <leader>e :e! ~/.vim_runtime/my_configs.vim<cr>

set encoding=UTF-8
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

syntax on
filetype plugin indent on
"---------------------------- Plugins ----------------------------
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'rwxrob/vim-pandoc-syntax-simple'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
call plug#end()

colorscheme gruvbox
set cursorline
set cursorlineopt=number
" highlight CursorLine ctermbg=0
highlight CursorLineNr ctermfg=Yellow ctermbg=0

" Background transparente
highlight Normal guibg=NONE ctermbg=NONE

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Tab as space, as it should
set tabstop =2
set softtabstop =2
set shiftwidth =2
set expandtab

"----------------- COC ------------------

" nnoremap ]a l :call CocAction('diagnosticNext')<CR>
" nnoremap [a h :call CocAction('diagnosticPrevious')<CR>
" " autocmd BufNew,BufEnter *.json,*.ts,*html,*go execute "silent! CocEnable"
" " autocmd BufLeave *.json,*.ts,*html,*go execute "silent! CocDisable"
" nnoremap <silent> <leader>k :let getHover=CocAction('getHover')<CR>:tabnew<CR>:put=getHover<CR>

"----------------- LSP ------------------

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    " nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [a <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]a <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>d <plug>(lsp-document-diagnostics)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    " For Vim 8 (<c-@> corresponds to <c-space>):
    let g:lsp_format_sync_timeout = 1000
    let g:lsp_document_code_action_signs_enabled = 0
    let g:lsp_hover_ui = 'preview'
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction
imap <c-@> <Plug>(asyncomplete_force_refresh)

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"----------------- Go Lang settings ---------------------
"“ Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1

let g:go_test_timeout="180s"
" Run test on builtin terminal
let g:go_term_enabled = 1
let g:go_term_reuse = 1
let g:go_term_mode = "split"
"LSP que deve encontrar definitions
let g:go_def_mapping_enabled = 0
"rather than the preview-window
" let g:go_doc_popup_window = 1
"Go Path
let g:go_bin_path = $HOME."/go/bin"
augroup gobindings
  au! gobindings
  au FileType go
        \  nmap <buffer> <silent> <leader>dt <plug>(go-def-tab)
        \| nmap <buffer> <silent> <leader>r :w<CR><S-G>o<CR>/*<CR>*/<Esc><S-o>:.!if test -f go.mod; then { go run .; } else { go run main.go; } fi<CR>
        \| nmap <buffer> <silent> <leader>t <plug>(go-test-func)
        \| nmap <silent> gd <plug>(go-def)
        \| nmap <buffer> <silent> <leader>tt <plug>(go-alternate-vertical)
        \| nmap <leader>i !ipgojson<CR>
        \| nmap <leader>b :!godistbuild<CR>
        \| nnoremap <buffer> <silent> <leader>c :GoFillStruct<CR>
augroup end

let g:go_play_browser_command = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe %URL% &'

"-------------- Snippets -----------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"

let g:UltiSnipsSnippetDirectories=["UltiSnips", $DOTFILES.'/UltiSnips']

"-------------- TypeScript --------------------------

augroup tsbindings
  au! tsbindings
  au FileType typescript
        \  nnoremap <leader>r :w<CR><S-G>o<CR>:.!tscrun<CR> 
        \| nnoremap <leader>t :call RunApiTest()<CR>
        \| nnoremap <leader>i <S-v>}:s/\n//<CR>!!json2ts<CR>:nohl<CR>
        \| nnoremap <leader>f f(lca"url<S-o>const url = pA;const options = j<S-a>ca{optionsk$p%<S-a>;j<S-i>const res = await oconst data = await res.json();
        \| nnoremap <leader>f f(lca"url<S-o>const url = pA;const options = j<S-a>ca{optionsk$p%<S-a>;j<S-i>const res = await oconst data = await res.json();
augroup end

function RunApiTest()
  let pos = getcurpos()
  execute '!' . "./testapi.bash" . " " . expand("%") . " " . pos[1]
endfunction

"-------------- Git Gutter --------------------------
let g:gitgutter_enabled=1
let g:gitgutter_set_sign_backgrounds=1
set signcolumn=yes
nmap [s <plug>(GitGutterPrevHunk)
nmap ]s <plug>(GitGutterNextHunk)
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ------- Open FZF search in vim -------------------
map <C-f> <Esc><Esc>:GFiles!<CR>
inoremap <C-f> <Esc><Esc>:BLines!<CR>
map <C-g> <Esc><Esc>:BCommits!<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Navegar buffers
nmap <C-d> <Esc><Esc>:Buffers<CR>
nmap <C-s> <Esc><Esc>:Rg!<CR>

" -------- Making Vim with Typescript faster -----
" set re=0
" set regexpengine=1
set synmaxcol=200
set redrawtime=10000
syntax sync fromstart

" Atalho para Git Status
nnoremap <leader>g :G<CR><C-w>o

set completeopt=menuone,noinsert,noselect,preview

" if you are gonna visual, might as well...
vmap < <gv
vmap > >gv

" make Y consitent with D and C (yank til end)
map Y y$

" " sh macros
" au FileType sh let @w = 'ciw${p'

" disable arrow keys (vi muscle memory)
noremap <up> :echoerr "arrow keys 💩"<CR>
noremap <down> :echoerr "arrow keys 💩"<CR>
noremap <left> :echoerr "arrow keys 💩"<CR>
noremap <right> :echoerr "arrow keys 💩"<CR>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> ``<left>
inoremap <right> <NOP>

nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap N Nzz
nnoremap s 0
nnoremap ç $
vnoremap s 0
vnoremap ç $
nnoremap <leader>aa ggVG
" c/ — Show a count of search results.
nnoremap <Leader>c/ :%s/<C-r>// /gn<CR>

inoremap ,, A,
inoremap ;; A;

augroup jsbindings
  au! jsbindings
  au FileType javascript 
        \  nnoremap <leader>r :w<CR><S-G>o<CR>:.!node index.js<CR> 
augroup end

au FileType sh nnoremap <leader>r :w<CR><S-G>o<CR>:call RunShell()<CR>
au FileType bash nnoremap <leader>r :w<CR><S-G>o<CR>:call RunShell()<CR>
au FileType python nnoremap <leader>r :w<CR><S-G>o<CR>"""o"""O!!python3 %<CR>

function RunShell()
  execute '.!' . expand("%:p")
endfunction

let g:pandoc#spell#enabled=0

" Paste replace visual selection without coyping it
vnoremap p "_dP

" Set filetypes
nnoremap <leader>fb :set ft=bash<CR>
nnoremap <leader>fp :set ft=python<CR>
nnoremap <leader>fjs :set ft=javascript<CR>
nnoremap <leader>ft :set ft=typescript<CR>
nnoremap <leader>fg :set ft=go<CR>
nnoremap <leader>fjo :set ft=json<CR>

nnoremap <leader>vt :vert term<CR>
nnoremap <leader>l :cex system('npm run --silent lint:unix')<CR>

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
