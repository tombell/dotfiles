vim.call('plug#begin', '~/.config/nvim/plugged')

-- color schemes

vim.fn['plug#']('catppuccin/nvim', { as = 'catppuccin' })

-- fuzzy finding

vim.fn['plug#']('nvim-lua/plenary.nvim')
vim.fn['plug#']('nvim-telescope/telescope.nvim')

-- utilities

vim.fn['plug#']('editorconfig/editorconfig-vim')
vim.fn['plug#']('tpope/vim-commentary')

-- language servers

vim.fn['plug#']('neovim/nvim-lspconfig')

-- typescript/javascript

vim.fn['plug#']('HerringtonDarkholme/yats.vim')
vim.fn['plug#']('pangloss/vim-javascript')
vim.fn['plug#']('MaxMEllon/vim-jsx-pretty')

-- toml

vim.fn['plug#']('cespare/vim-toml')

-- swift
vim.fn['plug#']('keith/swift.vim')

-- sql

vim.fn['plug#']('lifepillar/pgsql.vim')

-- css

vim.fn['plug#']('hail2u/vim-css3-syntax')

vim.call('plug#end')
