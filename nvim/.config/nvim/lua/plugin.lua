local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

local no_packer = vim.fn.empty(vim.fn.glob(install_path, nil, nil)) > 0
if no_packer then
  local args = {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
  packer_bootstrap = vim.fn.system(args)
end

require('packer').startup(function(use)
  -- goes first
  use 'wbthomason/packer.nvim'

  -- basics
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-rhubarb'
  use 'windwp/nvim-autopairs'
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-tree/nvim-tree.lua'

  -- pickers
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- lua dev
  use 'folke/neodev.nvim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- statusline
  use 'nvim-lualine/lualine.nvim'

  -- lsp things
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'stevearc/dressing.nvim'
  use 'antosha417/nvim-lsp-file-operations'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- themes
  use 'quentin-fox/onedark.vim'
  use 'rakr/vim-one'

  -- gh
  -- use 'pwntester/octo.nvim'

  -- goes last
  if packer_bootstrap then
    require('packer').sync()
  end
end)
