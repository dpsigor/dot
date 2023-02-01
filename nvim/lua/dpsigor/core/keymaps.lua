local M = {}

vim.g.mapleader = " "

local km = vim.keymap

km.set("n" ,"0", "^")
km.set("n", "<leader>w", ":w!<cr>")
vim.api.nvim_set_keymap('n', "<leader><cr>", ":noh<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>e', ':e $HOME/.config/nvim/lua/dpsigor/core/keymaps.lua<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "<leader>s", "*<S-n>cgn", { noremap = true, silent = true })

-- quickfix
vim.api.nvim_set_keymap('n', "<leader>cc", ":botright cope<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>j", ":cn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>k", ":cp<CR>", { noremap = true, silent = true })

-- disable arrow keys (vi muscle memory)
vim.api.nvim_set_keymap('n', "<up>", ":echoerr 'arrow keys 💩'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<down>", ":echoerr 'arrow keys 💩'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<left>", ":echoerr 'arrow keys 💩'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<right>", ":echoerr 'arrow keys 💩'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "<up>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "<down>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "<left>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "<right>", "<NOP>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "k", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "n", "nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "N", "Nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "s", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "ç", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "s", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "ç", "$", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "<leader>aa", "ggVG", { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', "p", "\"_dP", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ">", ">gv", { noremap = true, silent = true })

-- filetypes
vim.api.nvim_set_keymap('n', "<leader>fb", ":set ft=bash<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>fjs", ":set ft=javascript<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>fts", ":set ft=typescript<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>fg", ":set ft=go<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>fjo", ":set ft=json<CR>", { noremap = true, silent = true })

-- terminal
vim.api.nvim_set_keymap('n', "<leader>vt", ":vsplit term://bash<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>vs", ":split term://bash<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-w>h", "<C-\\><C-n><C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-w>j", "<C-\\><C-n><C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-w>k", "<C-\\><C-n><C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-w>l", "<C-\\><C-n><C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', "<C-p>", "<C-\\><C-n>pi", { noremap = true, silent = true })

-- resize window
vim.api.nvim_set_keymap('n', "<leader>vr", ":vert resize 140<CR>", { noremap = true, silent = true })

-- nvim-tree
vim.api.nvim_set_keymap('n', "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- fzf
vim.api.nvim_set_keymap('n', "<C-d>", "<cmd>Buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<C-f>", "<cmd>GFiles!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<C-s>", "<cmd>Rg!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<C-g>", "<cmd>BCommits!<CR>", { noremap = true, silent = true })

-- -- telescope
-- vim.api.nvim_set_keymap('n', "<C-d>", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', "<C-f>", "<cmd>Telescope find_files hidden=true<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', "<C-s>", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap('n', "<C-g>", "<cmd>Telescope git_bcommits<CR>", { noremap = true, silent = true })

-- LSP
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', "gD", '<cmd>Lspsaga peek_definition<CR>', opts)
vim.api.nvim_set_keymap('n', "gd", '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', "gi", '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', "gr", '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', "<leader>ca", '<cmd>Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('n', "<leader>rn", '<cmd>Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', "<leader>d", '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.api.nvim_set_keymap('n', "[a", '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.api.nvim_set_keymap('n', "]a", '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.api.nvim_set_keymap('n', "K", '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', "<leader>o", '<cmd>LSoutlineToggle<CR>', opts)

-- runtest script
function M.runtest()
  local ln = vim.api.nvim_win_get_cursor(0)[1]
  local fpath = vim.fn.expand('%')
  
  local create_with = ":vsplit term://bash"
  local current_id = vim.api.nvim_get_current_buf()
  vim.cmd(create_with)
  local buf_id = vim.api.nvim_get_current_buf()
  local term_id = vim.b.terminal_job_id
  if term_id == nil then
    log.error("nao conseguiu criar terminal")
    return nil
  end
  vim.api.nvim_buf_set_option(buf_id, "bufhidden", "hide")
  vim.api.nvim_chan_send(term_id, "./runtest.bash "..fpath.." "..ln.."\n")
end

-- typescript
vim.api.nvim_set_keymap('n', "<leader>t", ':lua require"dpsigor.core.keymaps".runtest()<CR>', { noremap = true, silent = true })

-- fugitive
vim.api.nvim_set_keymap('n', "<leader>g", ':G<CR><C-w>o', { noremap = true, silent = true })

-- vinegar
vim.api.nvim_set_keymap('n', "-", '<Plug>VinegarUp', { noremap = true, silent = true })

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.api.nvim_set_keymap("i", "<C-G>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_filetypes = {
  ["*"] = false,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = false,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["md"] = true,
  ["python"] = true,
}

-- " Make sure that enter is never overriden in the quickfix window
-- autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
--

-- local helpers
vim.api.nvim_set_keymap('n', "<leader>l", ":cex system('npm run --silent lint:unix')<CR>", { noremap = true, silent = true })

return M
