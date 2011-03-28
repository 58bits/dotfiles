" Maintainer:  Anthony Bouch (tony@58bits.com)
" Last Change: 2011-03-24
" Version:     1.0.0
" License:     This script is free software; you can redistribute it and/or
"              modify it under the terms of either the Artistic License or
"              the GNU General Public License.
"
" Vim global plugin for providing templates for new files
" Based on Aristotle Pagaltzis <pagaltis@gmz.de> template script.
" Modified to use .tpl exenstions and a filetype definition at the top of the
" template.
"
" Create a 'templates' directory in your .vim directory and place your .tpl
" templates here. For example a bash.tpl template, or a css.tpl, or any file
" that you would like to load as a template - as long as it ends in .tpl
" 
" In order to tell Vim to use the correct filetype for editing, you must place
" the following text on the first line of the template:

" # template: xhtml

" This will cause the vim filetype to be set to xhtml. The template definition
" will then be removed from the newly created buffer.
" 
" To load a template use the 'Boost' command followed by the template name
" (without the .tpl suffix).
"
" For example:
" :Boost html (loads the html.tpl template into the current buffer)
" :Boost html-strict (loads the html-strict template into the current buffer)
" :Boost bash (loads the bash.tpl template into the current buffer)
" :Boost mytemplate (loads the mytemplate.tpl template into the current buffer)


if exists( 'g:loaded_boost' ) | finish | endif
let g:loaded_boost = 1

function! s:globpathlist( path, ... )
    let i = 1
    let result = a:path
    while i <= a:0
        let result = substitute( escape( globpath( result, a:{i} ), ' ,\' ), "\n", ',', 'g' )
        if strlen( result ) == 0 | return '' | endif
        let i = i + 1
    endwhile
    return result
endfunction

function! s:loadtemplate( template )
    let templatefile = matchstr( s:globpathlist( &runtimepath, 'templates', a:template . '.tpl' ), '\(\\.\|[^,]\)*', 0 )
    if strlen( templatefile ) == 0 | return | endif
    silent execute 1 'read' templatefile
    1 delete _
    call s:setfiletype()
    call s:setcursor() 
    set nomodified
endfunction

function! s:setcursor()
    if search( 'cursor:', 'W' )
        let cursorline = strpart( getline( '.' ), col( '.' ) - 1 )
        let y = matchstr( cursorline, '^cursor:\s*\zs\d\+\ze' )
        let x = matchstr( cursorline, '^cursor:\s*\d\+\s\+\zs\d\+\ze' )
        let d = matchstr( cursorline, '^cursor:\s*\d\+\s\+\(\d\+\s\+\)\?\zsdel\>\ze' )
        if ! strlen( x ) | let x = 0 | endif
        if ! strlen( y ) | let y = 0 | endif
        if d == 'del' | delete _ | endif
        call cursor( y, x )
    endif
endfunction

function! s:setfiletype()
    if search( 'filetype:', 'W' )
        let cursorline = strpart( getline( '.' ), col( '.' ) - 1 )
        let f = matchstr( cursorline, '^filetype:\s*\zs.\+\ze' )
        let &filetype=f
        1 delete _
    endif
endfunction

command -nargs=1 Boost call s:loadtemplate( <f-args> ) 
