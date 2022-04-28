vim.call('plug#begin', '~/.config/nvim/plugged')

local plug = vim.fn['plug#']

-- color schemes

plug('catppuccin/nvim', { as = 'catppuccin' })

-- fuzzy finding

plug('nvim-lua/plenary.nvim')
plug('nvim-telescope/telescope.nvim')

-- utilities

plug('editorconfig/editorconfig-vim')
plug('tpope/vim-commentary')

-- language servers

plug('neovim/nvim-lspconfig')

-- typescript/javascript

plug('HerringtonDarkholme/yats.vim')
plug('pangloss/vim-javascript')
plug('MaxMEllon/vim-jsx-pretty')

-- toml

plug('cespare/vim-toml')

-- swift

plug('keith/swift.vim')

-- sql

plug('lifepillar/pgsql.vim')

-- css

plug('hail2u/vim-css3-syntax')

vim.call('plug#end')
