vim.keymap.set('n', '<leader>gf', function()
  local line_content = vim.api.nvim_get_current_line()
  local file_path = line_content:match '([^ ]-):%d+'
  if not file_path then
    local next_line = vim.api.nvim_buf_get_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1] + 1, false)[1]
    if not next_line then
      return
    end
    line_content = line_content .. next_line
    file_path = line_content:match '([^ ]-):%d+'
  end
  if not file_path then
    return
  end
  local line_number = line_content:match '[^ ]-:(%d+)'
  vim.api.nvim_command 'wincmd h'
  vim.api.nvim_command('e ' .. file_path)
  vim.api.nvim_command(line_number)
end, { silent = true })

return {}
