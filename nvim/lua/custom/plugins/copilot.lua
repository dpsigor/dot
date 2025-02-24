vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
vim.g.copilot_proxy_strict_ssl = false

return {
  {
    'github/copilot.vim',
  },
}
