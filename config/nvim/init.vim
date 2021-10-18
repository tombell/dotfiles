source ~/.config/nvim/packages.vim

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
let g:sonokai_style = "atlantis"
colorscheme sonokai

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
  if !col
    return "\<tab>"
  endif
  let char = getline('.')[col - 1]
  if char =~ '\k'
    return "\<c-p>"
  else
    return "\<tab>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

let g:html_indent_tags = "li\|p"

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
let g:fzf_layout = {"down": "20%"}

let g:sql_type_default = "pgsql"
