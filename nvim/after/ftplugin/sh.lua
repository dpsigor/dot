vim.keymap.set('n', '<leader>r', function()
  local filename = vim.api.nvim_buf_get_name(0)
  vim.api.nvim_command 'e $HOME/throwaway.json'
  vim.api.nvim_command 'normal! Gocco'
  vim.api.nvim_command('.!' .. filename)
end)

return {}
