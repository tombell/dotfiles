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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Utility
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/vim-gitbranch'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" JavaScript
Plug 'pangloss/vim-javascript'

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'Quramy/tsuquyomi'

" Stylesheets
Plug 'hail2u/vim-css3-syntax'

" Templating
Plug 'joukevandermaas/vim-ember-hbs', { 'for': 'handlebars' }

" Markdown
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }

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

" Detect when a html or markdown file required liquid highlighting
au BufNewFile,BufRead */_layouts/*.html,*/_includes/*.html set ft=liquid
au BufNewFile,BufRead *.html,*.xml,*.textile
  \ if getline(1) == '---' | set ft=liquid | endif
au BufNewFile,BufRead *.markdown,*.mkd,*.mkdn,*.md
  \ if getline(1) == '---' |
  \  let b:liquid_subtype = 'markdown' |
  \  set ft=liquid |
  \ endif

" Use ctrl-p for fuzzy file finding
nnoremap <silent> <C-p> :Files<cr>

" Default fzf layout
let g:fzf_layout = { 'down': '~10%' }

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

function! StatuslineGitBranch()
  let l:branchname = gitbranch#name()
  return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ''
endfunction

" Configure a new statusline
set statusline=

" Git branch information
set statusline+=%2*%{StatuslineGitBranch()}

" Current file information
set statusline+=\%*
set statusline+=%1*\ ‹‹
set statusline+=%1*\ %f
set statusline+=%1*\ ››
set statusline+=%1*\ %m

" Line and column number information
set statusline+=%=
set statusline+=%2*\ ‹‹
set statusline+=%2*\ %l
set statusline+=%2*\ ::
set statusline+=%2*\ %c
set statusline+=%2*\ ››\ %*

hi User1 guifg=#f8f8f2 guibg=#44475a
hi User2 guifg=#000000 guibg=#bd93f9
hi User3 guifg=#000000 guibg=#98D750
