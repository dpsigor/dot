return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Load during startup
    config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
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
        inverse = true, -- invert background for search, diffs, etc.
        contrast = 'medium', -- 'soft', 'medium', or 'hard'
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
      -- vim.cmd 'colorscheme gruvbox'
    end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_foreground = 'original'
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
