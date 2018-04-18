let g:tsuquyomi_completion_detail = 1

autocmd FileType typescript setl omnifunc=tsuquyomi#complete

" Override the highlight type for this, because by default it's ugly
hi def link typescriptPredefinedType Type
