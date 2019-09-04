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

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }

" Fuzzy file-finding
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Utility
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tombell/trailing.vim'
Plug 'tpope/vim-commentary'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'for': [
    \ 'javascript',
    \ 'ruby',
    \ 'typescript' ] }

" TOML
Plug 'cespare/vim-toml'

" SQL
Plug 'lifepillar/pgsql.vim'

" Go
Plug 'fatih/vim-go'

" Ruby
Plug 'tpope/vim-rails'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'Quramy/tsuquyomi'

" Stylesheets
Plug 'hail2u/vim-css3-syntax'

" Markdown
Plug 'plasticboy/vim-markdown'

" Haskell
Plug 'neovimhaskell/haskell-vim'

call plug#end()

filetype plugin indent on

if has("termguicolors")
  set termguicolors
endif

syntax on
set background=dark
colorscheme dracula

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

" Remove preview window when using completion
set completeopt-=preview

" Set ruby path to be the rbenv shims directory
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Set all SQL files to use PSQL highlighting
let g:sql_type_default = 'pgsql'

" Detect when a html or markdown file requires liquid highlighting
au BufNewFile,BufRead */_layouts/*.html,*/_includes/*.html set ft=liquid
au BufNewFile,BufRead *.html,*.xml
  \ if getline(1) == '---' | set ft=liquid | endif
au BufNewFile,BufRead *.markdown,*.mkd,*.mkdn,*.md
  \ if getline(1) == '---' |
  \  let b:liquid_subtype = 'markdown' |
  \  set ft=liquid |
  \ endif

" Detect when a html file requires Go HTML template highlighting.
au BufNewFile,BufRead *.html,*.xml
  \ if getline(1) == '+++' | set ft=gohtmltmpl | endif

" Use ctrl-p for fuzzy file finding
nnoremap <silent> <C-p> :Files<cr>

" Default fzf layout
let g:fzf_layout = { 'down': '~25%' }

" Customize fzf colors to match your color scheme
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
