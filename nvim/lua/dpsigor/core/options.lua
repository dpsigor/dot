local opt = vim.opt

opt.number = true
opt.visualbell = true
opt.fileformat = "unix"
opt.fileformats = "unix"
opt.colorcolumn = "160"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.autoindent = true
opt.smartindent = true
opt.wrap = false

opt.backup = false
opt.wb = false
opt.swapfile = false

opt.encoding = "utf8"

opt.background = "dark"

opt.cursorline = true
opt.cursorlineopt = "number"
vim.api.nvim_set_hl(0, "CursorLineNR", { fg = "yellow" })

opt.errorbells = false
opt.visualbell = false

opt.magic = true

opt.lazyredraw = true

opt.smartcase = true
opt.ignorecase = true

opt.cmdheight = 2

opt.scrolloff = 7

opt.history = 500

opt.termguicolors = true

opt.signcolumn = "yes"

opt.backspace = "eol,start,indent"
opt.whichwrap = "b,s,<,>,h,l"

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "number"

opt.mouse = ""

-- Emojis
vim.cmd("ab :checked: ✅")
vim.cmd("ab :failed: 🚫")
vim.cmd("ab :warning: ⚠️")
vim.cmd("ab :pushpin: 📌")
vim.cmd("ab :bomb: 💣")
vim.cmd("ab :construction: 🚧")
vim.cmd("ab :point_right: 👉")
vim.cmd("ab :joia: 👍")
vim.cmd("ab :pray: 🙏")
vim.cmd("ab :brain: 🧠")
vim.cmd("ab :poo: 💩")

opt.undodir = vim.env.HOME.."/.neovim_temp_dirs/undodir"
opt.undofile = true

-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local nvim_create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

local autocmds = {
    terminal_job = {
        { "TermOpen", "*", "startinsert" };
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
    restore_cursor = {
        { 'BufRead', '*', [[call setpos(".", getpos("'\""))]] };
    };
}

nvim_create_augroups(autocmds)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.proto",
  callback = function() 
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command("execute '%!clang-format --assume-filename=x.proto --style=file'")
    vim.api.nvim_win_set_cursor(0, pos)
  end
})

-- vim.api.nvim_command("function FormatProto()")
-- vim.api.nvim_command("let cursor_pos = getpos('.')")
-- vim.api.nvim_command("execute '%!clang-format --assume-filename=x.proto --style=file'")
-- vim.api.nvim_command("call setpos('.', cursor_pos)")
-- vim.api.nvim_command("endfunction")
-- vim.api.nvim_command("augroup FormatProto")
-- vim.api.nvim_command("autocmd!")
-- vim.api.nvim_command("BufWritePre *.proto :call FormatProto()")
-- vim.api.nvim_command("augroup END")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.[ch]",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command("execute '%!clang-format --assume-filename=x.c --style=Google'")
    vim.api.nvim_win_set_cursor(0, pos)
  end
})

-- autocommands END

-- netrw
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

----------- TODO ------------------------------

-- autoclean white spaces

-- " Return to last edit position when opening files (You want this!)
-- au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

-- TESTAR Add a bit extra margin to the left
-- set foldcolumn=1

-- " Ignore compiled files
-- set wildignore=*.o,*~,*.pyc
-- if has("win16") || has("win32")
--     set wildignore+=.git\*,.hg\*,.svn\*
-- else
--     set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
-- endif

---------------------------------------------------

-- let &t_SI = "\<Esc>[6 q"
-- let &t_EI = "\<Esc>[2 q"

-- set ttimeoutlen=1
-- set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.

-- " Usar variável para abrir este rc com facilidade
-- let $RC="$HOME/.vim_runtime/my_configs.vim"
-- map <leader>e :e! ~/.vim_runtime/my_configs.vim<cr>

-- " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- " delays and poor user experience.
-- set updatetime=300

-- " prevents truncated yanks, deletes, etc.
-- set viminfo='20,<1000,s1000

-- " Don't pass messages to |ins-completion-menu|.
-- set shortmess+=c

-- " Always show the signcolumn, otherwise it would shift the text each time
-- " diagnostics appear/become resolved.
-- if has("nvim-0.5.0") || has("patch-8.1.1564")
--   " Recently vim can merge signcolumn and number column into one
--   set signcolumn=number
-- else
--   set signcolumn=yes
-- endif

-- syntax on
-- filetype plugin indent on
-- "---------------------------- Plugins ----------------------------
-- call plug#begin('~/.vim/plugged')
-- Plug 'itchyny/lightline.vim'
-- Plug 'jiangmiao/auto-pairs'
-- Plug 'prettier/vim-prettier', {
--   \ 'do': 'yarn install',
--   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
-- Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
-- Plug 'SirVer/ultisnips'
-- Plug 'junegunn/vim-easy-align'
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
-- Plug 'junegunn/fzf.vim'
-- Plug 'HerringtonDarkholme/yats.vim'
-- Plug 'rwxrob/vim-pandoc-syntax-simple'
-- Plug 'tpope/vim-vinegar'
-- Plug 'tpope/vim-commentary'
-- Plug 'tpope/vim-fugitive'
-- " Plug 'neoclide/coc.nvim', {'branch': 'release'}
-- Plug 'prabirshrestha/async.vim'
-- Plug 'prabirshrestha/vim-lsp'
-- Plug 'mattn/vim-lsp-settings'
-- Plug 'prabirshrestha/asyncomplete.vim'
-- Plug 'prabirshrestha/asyncomplete-lsp.vim'
-- Plug 'maxmellon/vim-jsx-pretty'
-- Plug 'pangloss/vim-javascript'
-- call plug#end()

-- " EasyAlign
-- " Start interactive EasyAlign in visual mode (e.g. vipga)
-- xmap ga <Plug>(EasyAlign)
-- " Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- nmap ga <Plug>(EasyAlign)

-- " Tab as space, as it should

-- "----------------- LSP ------------------

-- if executable('pyls')
--     " pip install python-language-server
--     au User lsp_setup call lsp#register_server({
--         \ 'name': 'pyls',
--         \ 'cmd': {server_info->['pyls']},
--         \ 'allowlist': ['python'],
--         \ })
-- endif

-- function! s:on_lsp_buffer_enabled() abort
--     setlocal omnifunc=lsp#complete
--     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
--     nmap <buffer> gd <plug>(lsp-definition)
--     nmap <buffer> gs <plug>(lsp-document-symbol-search)
--     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
--     nmap <buffer> gr <plug>(lsp-references)
--     nmap <buffer> gi <plug>(lsp-implementation)
--     " nmap <buffer> gt <plug>(lsp-type-definition)
--     nmap <buffer> <leader>rn <plug>(lsp-rename)
--     nmap <buffer> [a <plug>(lsp-previous-diagnostic)
--     nmap <buffer> ]a <plug>(lsp-next-diagnostic)
--     nmap <buffer> K <plug>(lsp-hover)
--     nmap <buffer> <leader>d <plug>(lsp-document-diagnostics)
--     nmap <buffer> <leader>ca <plug>(lsp-code-action)
--     let g:lsp_format_sync_timeout = 1000
--     let g:lsp_document_code_action_signs_enabled = 0
--     let g:lsp_hover_ui = 'preview'
-- endfunction
-- imap <c-@> <Plug>(asyncomplete_force_refresh)

-- let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']

-- augroup lsp_install
--     au!
--     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
--     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
-- augroup END

-- "----------------- Go Lang settings ---------------------
-- "“ Go syntax highlighting
-- let g:go_highlight_fields = 1
-- let g:go_highlight_functions = 1
-- let g:go_highlight_function_calls = 1
-- let g:go_highlight_extra_types = 1
-- let g:go_highlight_operators = 1
-- " Auto formatting and importing
-- let g:go_fmt_autosave = 1
-- let g:go_fmt_command = "goimports"
-- " Status line types/signatures
-- let g:go_auto_type_info = 1
-- let g:go_fmt_fail_silently = 1

-- let g:go_test_timeout="180s"
-- " Run test on builtin terminal
-- let g:go_term_enabled = 1
-- let g:go_term_reuse = 1
-- let g:go_term_mode = "split"
-- "LSP que deve encontrar definitions
-- let g:go_def_mapping_enabled = 0
-- "rather than the preview-window
-- " let g:go_doc_popup_window = 1
-- "Go Path
-- let g:go_bin_path = $HOME."/go/bin"
-- augroup gobindings
--   au! gobindings
--   au FileType go
--         \  nmap <buffer> <silent> <leader>dt <plug>(go-def-tab)
--         \| nmap <buffer> <silent> <leader>r :w<CR><S-G>o<CR>/*<CR>*/<Esc><S-o>:.!if test -f go.mod; then { go run .; } else { go run main.go; } fi<CR>
--         \| nmap <buffer> <silent> <leader>t <plug>(go-test-func)
--         \| nmap <silent> gd <plug>(go-def)
--         \| nmap <buffer> <silent> <leader>tt <plug>(go-alternate-vertical)
--         \| nmap <leader>i !ipgojson<CR>
--         \| nmap <leader>b :!godistbuild<CR>
--         \| nnoremap <buffer> <silent> <leader>c :GoFillStruct<CR>
-- augroup end

-- let g:go_play_browser_command = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe %URL% &'


-- "-------------- TypeScript --------------------------

-- augroup tsbindings
--   au! tsbindings
--   au FileType typescript
--         \  nnoremap <leader>r :w<CR><S-G>o<CR>:.!tscrun<CR> 
--         \| nnoremap <leader>t :call RunApiTest()<CR>
--         \| nnoremap <leader>i <S-v>}:s/\n//<CR>!!json2ts<CR>:nohl<CR>
-- augroup end

-- function RunApiTest()
--   let pos = getcurpos()
--   execute 'vert term' . "./runtest.bash" . " " . expand("%") . " " . pos[1]
-- endfunction

-- " ------- Open FZF search in vim -------------------
-- map <C-f> <Esc><Esc>:GFiles!<CR>
-- inoremap <C-f> <Esc><Esc>:BLines!<CR>
-- map <C-g> <Esc><Esc>:BCommits!<CR>

-- let g:fzf_action = {
--   \ 'ctrl-t': 'tab split',
--   \ 'ctrl-x': 'split',
--   \ 'ctrl-v': 'vsplit' }

-- " Navegar buffers
-- nmap <C-d> <Esc><Esc>:Buffers<CR>
-- nmap <C-s> <Esc><Esc>:Rg!<CR>

-- " -------- Making Vim with Typescript faster -----
-- " set re=0
-- " set regexpengine=1
-- set synmaxcol=200
-- set redrawtime=10000
-- syntax sync fromstart

-- " Atalho para Git Status
-- nnoremap <leader>g :G<CR><C-w>o

-- set completeopt=menuone,noinsert,noselect,preview

-- function FormatH()
--   let cursor_pos = getpos('.')
--   execute "%!clang-format --assume-filename=x.h --style=Google"
--   call setpos('.', cursor_pos)
-- endfunction

-- autocmd BufWritePre *.h :call FormatH()

-- " header files aqui...
-- set path+=/usr/include/x86_64-linux-gnu
-- set path+=/usr/local/include/

---------------------------------------------------------------
