call plug#begin()

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

" Colour schemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'franbach/miramare'
" Plug 'cocopon/colorswatch.vim'
" Plug 'cocopon/inspecthi.vim'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Utilities
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier'
Plug 'tombell/trailing.vim'
Plug 'tpope/vim-commentary'

" Go
Plug 'fatih/vim-go'

" JavaScript & TypeScript
Plug 'Quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" Misc. language support
Plug 'cespare/vim-toml'
Plug 'hail2u/vim-css3-syntax'
Plug 'lifepillar/pgsql.vim'

call plug#end()

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
colorscheme miramare

" JSX/TSX tweaks
hi link jsxTagName jsxComponentName
hi link jsxCloseString Green

" TypeScript tweaks
hi link typescriptTypeAnnotation Operator
hi link typescriptObjectColon Operator

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes
let g:is_posix = 1

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation
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

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

set splitbelow
set splitright

" Easier omnicomplete triggering
inoremap <C-space> <C-x><C-o>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Close quickfix and location list windows
nnoremap <Leader>a :cclose<Bar>:lclose<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Reflow paragraph in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

nnoremap <silent> <C-p> :Files<cr>

set completeopt-=preview

let g:sql_type_default = 'pgsql'

let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '20%' }
