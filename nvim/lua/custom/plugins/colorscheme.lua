return {
  {
    'sainnhe/gruvbox-material',
    config = function()
      -- vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_enable_bold = 1
      vim.cmd 'colorscheme gruvbox-material'
    end,
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
    -- config = function()
    --   vim.cmd 'colorscheme kanagawa'
    -- end,
  },
  {
    'tjdevries/colorbuddy.nvim',
  },
}
