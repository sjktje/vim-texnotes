if exists('g:loaded_texnotes') || v:version < 700
    finish
endif
let g:loaded_texnotes = 1

function! ReplaceQuotesWithTexQuotes()
    %s/"\(\_.\{-}\)"/``\1''/g
endfunction

command! -bar -range=% TexQuotes :call ReplaceQuotesWithTexQuotes()

function! TexnotesItemize()
    let linenr = 0
    let itemizeblock = 0
    while linenr < line("$")
        let linenr += 1
        let line = getline(linenr)

        if line =~ '^---$'
            if itemizeblock == 0
                let repl = substitute(line, '^---$', '\\begin{itemize}', '')
                let itemizeblock = 1
            else
                let repl = substitute(line, '^---$', '\\end{itemize}', '')
                let itemizeblock = 0
            endif

            call setline(linenr, repl)
            continue
        endif

        if itemizeblock == 1
            let repl = substitute(line, '^-', '    \\item', '')
            call setline(linenr, repl)
        endif
    endwhile
endfunction

command! -bar -range=% TexnotesItemize :call TexnotesItemize()

function! TexnotesEnumerate()
    let linenr = 0
    let itemizeblock = 0
    while linenr < line("$")
        let linenr += 1
        let line = getline(linenr)

        if line =~ '^###$'
            if itemizeblock == 0
                let repl = substitute(line, '^###$', '\\begin{enumerate}', '')
                let itemizeblock = 1
            else
                let repl = substitute(line, '^###$', '\\end{enumerate}', '')
                let itemizeblock = 0
            endif

            call setline(linenr, repl)
            continue
        endif

        if itemizeblock == 1
            let repl = substitute(line, '^#', '    \\item', '')
            call setline(linenr, repl)
        endif
    endwhile
endfunction

command! -bar -range=% TexnotesEnumerate :call TexnotesEnumerate()

function! TexnotesNew()
    let suffix = 'a'
    let current_date = strftime("%Y-%m-%d")
    let file_name = current_date . suffix . '.tex'

    while filereadable(file_name)
        let suffix = nr2char(char2nr(suffix) + 1)
        let file_name = current_date . suffix . '.tex'
    endwhile

    exe 'e ' . file_name
endfunction

command! -bar -range=% TexnotesNew :call TexnotesNew()
