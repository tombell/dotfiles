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

set title
set cmdheight=2
set shortmess=filtIoOA

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if &compatible
  set nocompatible
end

call plug#begin()

Plug 'ajh17/Spacegray.vim'
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'

Plug 'cakebaker/scss-syntax.vim'
Plug 'fatih/vim-go'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'gregsexton/MatchTag'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-commentary'

call plug#end()

filetype plugin indent on

let macvim_skip_colorscheme = 1
set background=dark
colorscheme gruvbox

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
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

" Strip trailing whitespace
function! StripWhitespace()
  exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace()<CR>

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

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
