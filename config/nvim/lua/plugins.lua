local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--branch=stable',
		'https://github.com/folke/lazy.nvim.git', lazypath
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {	-- colour scheme
        'ellisonleao/gruvbox.nvim', priority = 1000, config = true
    },
    {	-- shortcuts
        'folke/which-key.nvim', event = 'VeryLazy'
    },
    {	-- tree sitter
        'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'
    },
    {	-- status bar
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
	{	-- buffer bar
		'akinsho/bufferline.nvim', version = '*',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
    {	-- file explorer
        'nvim-tree/nvim-tree.lua', version = '*', lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {	-- picker widget
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {	-- code editing
        'windwp/nvim-autopairs', event = 'InsertEnter'
    },
    {	-- code editing
        'numToStr/Comment.nvim', lazy = false
    },
    {	-- code editing
        'lukas-reineke/indent-blankline.nvim'
    },
    {	-- session manager
        'rmagatti/auto-session'
    },
	{
		'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip'
		}
	}
})
