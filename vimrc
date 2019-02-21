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

if &compatible
  set nocompatible
end

call plug#begin()

if has('nvim')
  Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
endif

" Colors
Plug 'jacoborus/tender.vim'

" Utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" JavaScript/TypeScript
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ianks/vim-tsx'
Plug 'Quramy/tsuquyomi'

" SQL
Plug 'exu/pgsql.vim'

" Stylesheets
Plug 'hail2u/vim-css3-syntax'

" Templates
Plug 'joukevandermaas/vim-ember-hbs', { 'for': 'handlebars' }

" Caddy
Plug 'isobit/vim-caddyfile'

" Editing
Plug 'editorconfig/editorconfig-vim'
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-commentary'

call plug#end()

filetype plugin indent on

if has("termguicolors")
  set termguicolors
endif

syntax on
set background=dark
colorscheme tender

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
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
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

" Close quickfix and location list windows
nnoremap <Leader>a :cclose<Bar>:lclose<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Reflow paragraph in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" Remove preview window when using completion
set completeopt-=preview

" Set ruby path to be the rbenv shims directory
let g:ruby_path = system('echo $HOME/.rbenv/shims')
