function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " misc
  call minpac#add('Shougo/vimproc.vim', {'do': {-> system('make')}})

  " colour schemes
  call minpac#add('dracula/vim', {'name': 'dracula'})

  " fzf
  call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
  call minpac#add('junegunn/fzf.vim')

  " utilities
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('tombell/trailing.vim')
  call minpac#add('tpope/vim-commentary')

  " formatting and linting
  call minpac#add('prettier/vim-prettier')
  call minpac#add('dense-analysis/ale')

  " golang
  call minpac#add('fatih/vim-go')

  " javascript and typescript
  call minpac#add('Quramy/tsuquyomi')
  call minpac#add('HerringtonDarkholme/yats.vim')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('MaxMEllon/vim-jsx-pretty')

  " swift
  call minpac#add('keith/swift.vim')

  " misc. language support
  call minpac#add('cespare/vim-toml')
  call minpac#add('hail2u/vim-css3-syntax')
  call minpac#add('lifepillar/pgsql.vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

filetype plugin indent on

let mapleader = ","

set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set nohlsearch
set laststatus=2
set autowrite
set notitle
set cmdheight=2
set shortmess=filtIoOA
set termguicolors
set hidden

syntax on
set background=dark
packadd dracula
colorscheme dracula

let g:is_posix = 1

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set list listchars=tab:»·,trail:·,nbsp:·

set nojoinspaces

set textwidth=80
set colorcolumn=+1

set number
set numberwidth=5

set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-p>"
  endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

let g:html_indent_tags = 'li\|p'

set splitbelow
set splitright

inoremap <C-space> <C-x><C-o>

set completeopt-=preview

nnoremap <Leader>a :cclose<Bar>:lclose<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap Q gqap
vnoremap Q gq

nnoremap <silent> <C-p> :Files<cr>

let g:fzf_preview_window = []
let g:fzf_layout = {'down': '20%'}

let g:sql_type_default = 'pgsql'

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\   'typescript': ['eslint'],
\}
