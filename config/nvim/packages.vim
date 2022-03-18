function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " misc
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

  " colour schemes
  call minpac#add('sainnhe/sonokai')

  " fzf
  call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
  call minpac#add('junegunn/fzf.vim')

  " utilities
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('tombell/trailing.vim')
  call minpac#add('tpope/vim-commentary')

  " golang
  call minpac#add('fatih/vim-go')

  " json
  call minpac#add('neoclide/jsonc.vim')

  " javascript and typescript
  call minpac#add('HerringtonDarkholme/yats.vim')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('MaxMEllon/vim-jsx-pretty')

  " misc. language support
  call minpac#add('cespare/vim-toml')
  call minpac#add('hail2u/vim-css3-syntax')
  call minpac#add('lifepillar/pgsql.vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
