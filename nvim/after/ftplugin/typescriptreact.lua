local function toggleTestFile()
  local filename = vim.fn.expand '%'
  local is_test_file = string.match(filename, '_test.tsx')
  if is_test_file then
    local new_filename = string.gsub(filename, '_test.tsx', '.tsx')
    vim.cmd('edit ' .. new_filename)
  else
    local new_filename = string.gsub(filename, '.tsx', '_test.tsx')
    vim.cmd('edit ' .. new_filename)
  end
end

vim.keymap.set('n', '<leader>tt', toggleTestFile, { silent = true, noremap = true })

return {}
