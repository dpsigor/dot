local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
  return
end

gitsigns.setup({
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
})

vim.api.nvim_set_keymap('n', '[s', ':Gitsigns prev_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']s', ':Gitsigns next_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hu', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
