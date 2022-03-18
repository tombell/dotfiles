vim.call('plug#begin', '~/.config/nvim/plugged')

-- color schemes

vim.fn['plug#']('sainnhe/sonokai')

-- fzf

vim.fn['plug#']('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
vim.fn['plug#']('junegunn/fzf.vim')

-- utilities

vim.fn['plug#']('editorconfig/editorconfig-vim')
vim.fn['plug#']('tombell/trailing.vim')
vim.fn['plug#']('tpope/vim-commentary')

-- language servers

-- vim.fn['plug#']('neoclide/coc.nvim', { branch = 'release' })

-- json

-- vim.fn['plug#']('neoclide/jsonc.vim')

-- golang

-- vim.fn['plug#']('fatih/vim-go')

-- javascript and typescript

-- vim.fn['plug#']('HerringtonDarkholme/yats.vim')
-- vim.fn['plug#']('pangloss/vim-javascript')
-- vim.fn['plug#']('MaxMEllon/vim-jsx-pretty')

-- misc. language support

-- vim.fn['plug#']('cespare/vim-toml')
-- vim.fn['plug#']('hail2u/vim-css3-syntax')
-- vim.fn['plug#']('lifepillar/pgsql.vim')

vim.call('plug#end')
