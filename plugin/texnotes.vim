if exists('g:loaded_texnotes') || v:version < 700
    finish
endif
let g:loaded_texnotes = 1

function ReplaceQuotesWithTexQuotes()
    %s/"\(\_.\{-}\)"/``\1''/g
endfunction

command! -bar -range=% TexQuotes :call ReplaceQuotesWithTexQuotes()
