-- Golang specific settings

-- Alternate between test and implementation files
vim.keymap.set('n', '<leader>tt', function()
  local filename = vim.fn.expand '%:t'
  local dirname = vim.fn.expand '%:h'
  if not filename:match '_test.go' then
    local impl_filename = filename:gsub('.go', '_test.go')
    vim.cmd('edit ' .. dirname .. '/' .. impl_filename)
  else
    local test_filename = filename:gsub('_test.go', '.go')
    vim.cmd('edit ' .. dirname .. '/' .. test_filename)
  end
end)

-- Run tests
vim.keymap.set('n', '<leader>t', function()
  local filename = vim.fn.expand '%:t'
  if not filename:match '_test.go' then
    print 'Not a test file'
    return
  end
  local test_name_ln = vim.fn.search('^func Test', 'cbnW')
  local test_name = vim.fn.getline(test_name_ln):match '^func Test(.+)%('
  local cmd = 'rg --files --glob "*.go" | entr -r go test -race -count=1 -v -run="^Test' .. test_name .. '$" ./' .. vim.fn.expand '%:h'
  vim.api.nvim_command 'vsplit'
  vim.api.nvim_command('terminal  ' .. cmd)
  vim.cmd 'startinsert'
end)

return {}
