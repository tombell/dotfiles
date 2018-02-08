" Leader
let mapleader = ","

set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite

set notitle
set cmdheight=2
set shortmess=filtIoOA

if &compatible
  set nocompatible
end

let g:jsx_ext_required = 0

call plug#begin()

" tpope utilities
Plug 'tpope/vim-commentary'

" Workflow
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nicholaides/words-to-avoid.vim'

" Languages
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'

" Colors
Plug 'ayu-theme/ayu-vim'

call plug#end()

filetype plugin indent on

if has("termguicolors")
  set termguicolors
endif

let ayucolor="dark"
set background=dark

syntax on
colorscheme ayu

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Use one space, not two, after punctuation.
set nojoinspaces

" Use ripgrep https://github.com/BurntSushi/ripgrep
if executable('rg')
  " Use Rg over Grep
  set grepprg=rg\ --color=never

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

nnoremap <leader>a :cclose<cr>
nnoremap <leader>A :lclose<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Always use vertical diffs
set diffopt+=vertical

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Reflow paragraph in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" Get rid of the tooltips
set noballooneval
