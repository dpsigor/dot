local function formatPython()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd '%!black -t py310 -q -'
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- vim.cmd 'autocmd BufWritePre *.py :lua formatPython()'
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = formatPython,
})

return {}
