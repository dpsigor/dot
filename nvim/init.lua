vim.cmd('source /home/dpsigor/.config/nvim/dpsigor.vim')

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('ellisonleao/gruvbox.nvim')
Plug('SirVer/ultisnips')
Plug('tpope/vim-commentary')
Plug('jiangmiao/auto-pairs')

vim.call('plug#end')

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
