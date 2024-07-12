return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      contrast = 'dark',
    },
  },
  {
    'luisiacc/gruvbox-baby',
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    opts = {
      groups = {
        all = {
          IncSearch = { bg = 'orange' },
        },
      },
    },
    -- config = function()
    --   vim.cmd 'colorscheme terafox'
    -- end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1001,
    opts = {
      terminalColors = false,
    },
  },
  {
    'tjdevries/colorbuddy.nvim',
  },
}
