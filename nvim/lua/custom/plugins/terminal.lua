local terminal_in_insert_modes = {}

vim.keymap.set('t', '<C-n>', function()
  terminal_in_insert_modes[vim.fn.bufnr()] = false
  vim.cmd 'stopinsert'
  vim.cmd 'setlocal number'
end, { desc = 'Exit terminal mode' })

vim.keymap.set('t', '<C-w>h', function()
  terminal_in_insert_modes[vim.fn.bufnr()] = true
  local win = vim.fn.winnr '1h'
  vim.cmd(win .. 'wincmd w')
end)

vim.keymap.set('t', '<C-w>j', function()
  terminal_in_insert_modes[vim.fn.bufnr()] = true
  local win = vim.fn.winnr '1j'
  vim.cmd(win .. 'wincmd w')
end)

vim.keymap.set('t', '<C-w>k', function()
  terminal_in_insert_modes[vim.fn.bufnr()] = true
  local win = vim.fn.winnr '1k'
  vim.cmd(win .. 'wincmd w')
end)

vim.keymap.set('t', '<C-w>l', function()
  terminal_in_insert_modes[vim.fn.bufnr()] = true
  local win = vim.fn.winnr '1l'
  vim.cmd(win .. 'wincmd w')
end)

vim.keymap.set('n', '<leader>vt', function()
  vim.api.nvim_command 'vsplit'
  vim.api.nvim_command 'terminal'
  vim.cmd 'setlocal nonumber'
  vim.cmd 'startinsert'
end)
vim.keymap.set('n', '<leader>vs', function()
  vim.api.nvim_command 'split'
  vim.api.nvim_command 'terminal'
  vim.cmd 'setlocal nonumber'
  vim.cmd 'startinsert'
end)

vim.keymap.set('t', '<C-w>H', function()
  vim.cmd.wincmd 'H'
end)
vim.keymap.set('t', '<C-w>J', function()
  vim.cmd.wincmd 'J'
end)
vim.keymap.set('t', '<C-w>K', function()
  vim.cmd.wincmd 'K'
end)
vim.keymap.set('t', '<C-w>L', function()
  vim.cmd.wincmd 'L'
end)

vim.keymap.set('t', '<C-p>', '<C-\\><C-o>p')

vim.api.nvim_create_augroup('MyTerminal', {
  clear = true,
})

-- run aucommand whenever enter a window and verify if it is a terminal window
vim.api.nvim_create_autocmd('WinEnter', {
  group = 'MyTerminal',
  callback = function()
    local buf = vim.fn.bufnr()
    if terminal_in_insert_modes[buf] then
      vim.cmd 'startinsert'
    end
  end,
})

-- run aucommand whenever enter terminal mode
vim.api.nvim_create_autocmd('TermEnter', {
  group = 'MyTerminal',
  callback = function()
    vim.cmd 'setlocal nonumber'
  end,
})

return {}
