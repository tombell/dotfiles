call plug#begin()

" Required by tsuquyomi
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

" Linting
Plug 'dense-analysis/ale'

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'whatyouhide/vim-gotham'

" Fuzzy file-finding
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Utility
Plug 'editorconfig/editorconfig-vim'
Plug 'tombell/trailing.vim'
Plug 'tpope/vim-commentary'

" Prettier
Plug 'prettier/vim-prettier'

" Go
Plug 'fatih/vim-go'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" JavaScript & TypeScript
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" Misc. language support
Plug 'cespare/vim-toml'
Plug 'hail2u/vim-css3-syntax'
Plug 'lifepillar/pgsql.vim'
Plug 'keith/swift.vim'

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

syntax on
set background=dark
colorscheme gotham

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

set foldlevelstart=99
set foldmethod=syntax

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

" Use space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

set completeopt-=preview

let g:sql_type_default = 'pgsql'

let g:fzf_colors =
  \ { 'fg'      : ['fg', 'Normal'],
    \ 'bg'      : ['bg', 'Normal'],
    \ 'hl'      : ['fg', 'Comment'],
    \ 'fg+'     : ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+'     : ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+'     : ['fg', 'Statement'],
    \ 'info'    : ['fg', 'PreProc'],
    \ 'border'  : ['fg', 'Ignore'],
    \ 'prompt'  : ['fg', 'Conditional'],
    \ 'pointer' : ['fg', 'Exception'],
    \ 'marker'  : ['fg', 'Keyword'],
    \ 'spinner' : ['fg', 'Label'],
    \ 'header'  : ['fg', 'Comment'] }

" Fix some highlighting issues with JSX/TSX
augroup Fix_JSX_TSX_filetypes
  hi link jsxTagName jsxComponentName

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
