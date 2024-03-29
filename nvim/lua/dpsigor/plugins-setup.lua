local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use('nvim-lua/plenary.nvim')
  use('ellisonleao/gruvbox.nvim')
  use('windwp/nvim-autopairs')
  -- use('steelsojka/pears.nvim')
  use('terrortylor/nvim-comment')
  use('tpope/vim-vinegar')
  use('nvim-lualine/lualine.nvim')

  use('junegunn/fzf')
  use('junegunn/fzf.vim')
  -- use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  -- use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' })

  -- autocompletion
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')

  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  -- managing and installing lsp servers, linters and formatters
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')

  -- configuring lsp servers
  use('neovim/nvim-lspconfig')
  use('hrsh7th/cmp-nvim-lsp')
  use({ "glepnir/lspsaga.nvim", branch = "main" })
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")

  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  use("github/copilot.vim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })

  -- haskell
  use {
  'MrcJkb/haskell-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
