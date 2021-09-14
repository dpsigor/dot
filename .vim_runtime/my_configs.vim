" set number relativenumber
set number
set visualbell

set colorcolumn=160

let &t_SI = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Para subir e descer linhas, nos três modos. C-seta
nmap <silent> <C-Down> :m .+1<CR>==
nmap <silent> <C-Up> :m .-2<CR>==
imap <silent> <C-Down> <Esc>:m .+1<CR>==gi
imap <silent> <C-Up> <Esc>:m .-2<CR>==gi
vmap <silent> <C-Down> :m '>+1<CR>gv=gv
vmap <silent> <C-Up> :m '<-2<CR>gv=gv

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
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

syntax on
filetype plugin indent on
"---------------------------- Plugins ----------------------------
call plug#begin('~/.vim/plugged')
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'dense-analysis/ale'
Plug 'junegunn/vim-easy-align'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'rwxrob/vim-pandoc-syntax-simple'
Plug 'tpope/vim-vinegar'
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

"----------------- Go Lang settings ---------------------
"“ Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" let g:go_diagnostics_level = 2
" let g:go_highlight_diagnostic_errors = 1
" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1

let g:go_test_timeout="60s"
" Run test on builtin terminal
let g:go_term_enabled = 1
let g:go_term_reuse = 1
let g:go_term_mode = "split"
"LSP que deve encontrar definitions
let g:go_def_mapping_enabled = 0
"Go Path
let g:go_bin_path = $HOME."/go/bin"
augroup gobindings
  au! gobindings
  au FileType go
        \  nmap <buffer> <silent> <leader>dt <plug>(go-def-tab)
        \| nmap <buffer> <silent> <leader>r :w<CR><S-G>o<CR>/*<CR>*/<Esc><S-o>:.!if test -f go.mod; then { go run .; } else { go run main.go; } fi<CR>
        \| nmap <buffer> <silent> <leader>t <plug>(go-test-func)
        \| nmap <buffer> <silent> <leader>tt <plug>(go-alternate-vertical)
        \| nmap <leader>i !ipgojson<CR>
        \| nmap <leader>b :!godistbuild<CR>
        \| nnoremap <buffer> <silent> <leader>c :GoFillStruct<CR>
augroup end

let g:go_play_browser_command = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe %URL% &'

"-------------- Snippets -----------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"

"-------------- TypeScript --------------------------

let g:lsp_auto_enable = 1
nmap <silent> K <Plug>(lsp-hover)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> [g <plug>(lsp-previous-diagnostic)
nmap <silent> ]g <plug>(lsp-next-diagnostic)
nnoremap <leader>l :LspCodeAction<CR>
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_settings_root_markers = [
\   '.git',
\   '.git/',
\ ]
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))

if (executable('typescript-language-server'))
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->['typescript-language-server --stdio']},
        \ 'allowlist': ['javascript', 'typescript'],
        \ })
endif

if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'allowlist': ['sh'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! NgSwitch()
  let newextn = expand('%:e') == "ts" ? "html" : "ts"
  let switchfile = expand('%:r') . "." . newextn
  return switchfile
endfunction

augroup tsbindings
  au! tsbindings
  au FileType typescript
        \  nnoremap <leader>r :w<CR><S-G>o<CR>:.!tscrun<CR> 
        \| nnoremap <leader>t :w<CR>:!tsc<CR> 
        \| nnoremap <leader>i <S-v>}:s/\n//<CR>!!json2ts<CR>:nohl<CR>
        \| nnoremap <leader>f f(lca"url<S-o>const url = pA;const options = j<S-a>ca{optionsk$p%<S-a>;j<S-i>const res = await oconst data = await res.json();
        \| nnoremap <leader>f f(lca"url<S-o>const url = pA;const options = j<S-a>ca{optionsk$p%<S-a>;j<S-i>const res = await oconst data = await res.json();
        \| nnoremap <silent> <leader>n :vs <C-R>=NgSwitch()<CR><CR>
augroup end


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

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
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

" Prettier
" nnoremap <leader>f :Prettier<CR>
let g:prettier#autoformat_config_present = 1

" Atalho para cgn
nnoremap c* *Ncgn

" Atalho para Git Status
nnoremap <leader>g :G<CR>

" asyncomplete
let g:asyncomplete_auto_popup = 1
set completeopt=menuone,noinsert,noselect,preview

inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <c-space> <Plug>(asyncomplete_force_refresh)

" ALE
let g:ale_disable_lsp = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '❌'
let g:ale_sign_info = '🤔'
let g:ale_sign_style_error = '❌'
let g:ale_sign_style_warning = '🤔'
let g:ale_sign_warning = '🤔'
let g:ale_completion_enabled = 0
nnoremap ]a :ALENext<CR>
nnoremap [a :ALEPrevious<CR>

" if you are gonna visual, might as well...
vmap < <gv
vmap > >gv

" make Y consitent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

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
nnoremap <leader>a ggVG
" c/ — Show a count of search results.
nnoremap <Leader>c/ :%s/<C-r>// /gn<CR>

au FileType javascript nnoremap <leader>r :w<CR><S-G>o<CR>:.!node index.js<CR> 

let g:pandoc#spell#enabled=0
