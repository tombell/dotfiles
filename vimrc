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

call plug#begin()

" Mine
Plug 'tombell/trailing.vim'

" Utility
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-commentary'

" Syntaxes
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hail2u/vim-css3-syntax'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'

" Colors
Plug 'jacoborus/tender.vim'

call plug#end()

filetype plugin indent on

if has("termguicolors")
  set termguicolors
endif

syntax on
colorscheme tender

let g:lightline = { 'colorscheme': 'tender' }

set noballooneval

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

if executable('rg')
  set grepprg=rg\ --color=never

  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

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

" Easier omnicomplete triggering
inoremap <C-space> <C-x><C-o>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

" Close quickfix and location list windows
nnoremap <Leader>a :cclose<Bar>:lclose<CR>

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
