local function toggleTestFile()
  local filename = vim.fn.expand '%'
  local is_test_file = string.match(filename, '_test.ts')
  if is_test_file then
    local new_filename = string.gsub(filename, '_test.ts', '.ts')
    vim.cmd('edit ' .. new_filename)
  else
    local new_filename = string.gsub(filename, '.ts', '_test.ts')
    vim.cmd('edit ' .. new_filename)
  end
end

vim.keymap.set('n', '<leader>tt', toggleTestFile, { silent = true, noremap = true })

local function runTest()
  local filename = vim.fn.expand '%'
  if not filename:match '_test.ts' then
    print 'Not a test file'
    return
  end
  print(filename)
  local cmd = 'deno test --watch --fail-fast ' .. filename
  vim.api.nvim_command 'vsplit'
  vim.api.nvim_command('terminal  ' .. cmd)
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<leader>t', runTest, { silent = true, noremap = true })

return {}
