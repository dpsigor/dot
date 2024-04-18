vim.cmd('source /home/igor.psilva/.config/nvim/dpsigor.vim')

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('ellisonleao/gruvbox.nvim')
Plug('SirVer/ultisnips')
Plug('tpope/vim-commentary')
Plug('tpope/vim-fugitive')
Plug('tpope/vim-vinegar')
Plug('jiangmiao/auto-pairs')
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim')
Plug('neovim/nvim-lspconfig')
Plug('lewis6991/gitsigns.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug ('junegunn/fzf')
Plug('junegunn/fzf.vim')

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

require('gitsigns').setup{
  signcolumn = true,
  word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']s', function()
      if vim.wo.diff then
        vim.cmd.normal({']s', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[s', function()
      if vim.wo.diff then
        vim.cmd.normal({'[s', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hu', gitsigns.reset_hunk)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    map('n', '<leader>td', gitsigns.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = {"vimdoc","lua"},

    -- -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

-- fugitive
vim.keymap.set("n", "<leader>g", ":G<CR><C-w>o", {})

-- fzf
-- TODO: use telescope for this. Must configure git_bcommits to output as this
vim.keymap.set("n", "<C-g>", ":BCommits<CR>", {})

require('dpsigor_telescope')

require('dpsigor_lsp')
