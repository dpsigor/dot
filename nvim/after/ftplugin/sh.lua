vim.keymap.set('n', '<leader>r', function()
  vim.api.nvim_command 'normal! G$o<CR>cc<CR><CR>'
  local filename = vim.api.nvim_buf_get_name(0)
  vim.api.nvim_command('.!' .. filename)
end)

return {}
