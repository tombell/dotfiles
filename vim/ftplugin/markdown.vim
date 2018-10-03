" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80

" Limelight settings
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

" Set fullscreen and linespace when entering goyo
function! s:goyo_enter()
  if has('gui_running')
    set linespace=7
  endif
  Limelight
endfunction

" Reset fullscreen and linespace when leaving goyo
function! s:goyo_leave()
  if has('gui_running')
    set linespace=0
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Toggle goyo
nnoremap <Leader>G :Goyo<CR>

let g:markdown_enable_insert_mappings = 0
