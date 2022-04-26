vim.call('plug#begin', '~/.config/nvim/plugged')

-- color schemes

vim.fn['plug#']('catppuccin/nvim', { as = 'catppuccin' })

-- utilities

vim.fn['plug#']('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
vim.fn['plug#']('junegunn/fzf.vim')

vim.fn['plug#']('editorconfig/editorconfig-vim')
vim.fn['plug#']('tombell/trailing.vim')
vim.fn['plug#']('tpope/vim-commentary')

-- language servers

vim.fn['plug#']('neoclide/coc.nvim', {
  branch = 'release',
  ['for'] = {
    'javascript',
    'javascriptreact',
    'swift',
    'typescript',
    'typescriptreact',
    'zig',
  },
})

-- golang

vim.fn['plug#']('fatih/vim-go')

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

-- jsonc

vim.fn['plug#']('neoclide/jsonc.vim')

vim.call('plug#end')
