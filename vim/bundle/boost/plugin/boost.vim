" Vim global plugin for providing templates for new files
" Based on Aristotle Pagaltzis <pagaltis@gmz.de> template script.
" Modified to use .tpl exenstions and regex for file types.
" The syntax for a template filename is <filetype>[-<name>].tpl
" For example:
" html.tpl is an html template.
" html-1.tpl is an html template and is named 1.
" html-strict.tpl is an html template and is named strict.
" css-reset.tpl is an css template named reset.
" To load a template use the 'Boost' command followed by the template name.
" For example:
" :Boost html (loads the html.tpl template into the current buffer)
" :Boost html-strict (loads the html-strict template into the current buffer)
" Maintainer:  Anthony Bouch (tony@58bits.com)
" Last Change: 2011-03-14
" License:     This script is free software; you can redistribute it and/or
"              modify it under the terms of either the Artistic License or
"              the GNU General Public License.

if exists( 'g:loaded_template' ) | finish | endif
let g:loaded_template = 1

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
    call s:setfiletype( a:template)
	set nomodified
endfunction

function! s:setfiletype( template )
    let ft = matchstr(a:template, '^[^-\.]*')
"    echo ft
    let &filetype=ft

endfunction

command -nargs=1 Boost call s:loadtemplate( <f-args> ) 
