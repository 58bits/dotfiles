function s:replace()
    let s:from = input("Search term:")
    let s:to = input("Replacement term:")
    let i=1
    while i < 99
        exe ":%s/" . s:from . "/" . s:to . "/gce"
        :bnext
        let i+= 1
    endwhile
endfunction

command -nargs=0 Replacer call s:replace()
