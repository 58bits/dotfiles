" Vim color file%>
" Last Updated by: Anthony Bouch <tony@58bits.com>
" Last Change: 2012 June 09

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "daring-dark"

" Normal should come first
" hi Normal     guifg=White  guibg=Black
" hi Cursor     guifg=bg     guibg=fg
hi Normal       guifg=#dddddd   guibg=Black
hi Cursor       guifg=Black     guibg=Grey
hi lCursor      guifg=NONE      guibg=Cyan

" Note: we never set 'term' because the defaults for B&W terminals are OK
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white 
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black 
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black 
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black 

"hi DiffAdd    ctermbg=LightBlue                         guibg=LightBlue
"hi DiffChange ctermbg=LightMagenta                      guibg=LightMagenta
"hi DiffDelete ctermfg=Blue	ctermbg=LightCyan           gui=bold guifg=Blue guibg=LightCyan
"hi DiffText   cterm=bold ctermbg=Red                    gui=bold guibg=Red

hi Directory  ctermfg=DarkBlue	                        guifg=Blue
hi ErrorMsg   ctermfg=White	ctermbg=DarkRed             guifg=White guibg=Red	    
hi FoldColumn ctermfg=DarkBlue ctermbg=Grey             guifg=DarkBlue guibg=Grey	    
hi Folded     ctermbg=Grey	ctermfg=DarkBlue            guifg=DarkBlue  guibg=LightGrey 
hi IncSearch  cterm=reverse	                            gui=reverse
hi LineNr     ctermfg=239	                            guifg=#4e4e4e
hi ModeMsg    cterm=bold                                gui=bold
hi MoreMsg    ctermfg=DarkGreen                         gui=bold guifg=SeaGreen
hi NonText    ctermfg=Blue                              gui=bold guifg=gray guibg=white
hi Pmenu      ctermfg=Blue ctermbg=232                  gui=bold guibg=#222222
hi PmenuSel   ctermfg=193 ctermbg=233                   guifg=#d7afff guibg=Black
hi Question   ctermfg=DarkGreen                         gui=bold guifg=SeaGreen
hi Search     ctermfg=250 ctermbg=238                    guifg=#bcbcbc guibg=#444444   
hi SpecialKey ctermfg=DarkBlue                          guifg=Blue
hi StatusLine cterm=reverse ctermbg=White ctermfg=Blue  gui=reverse guifg=#5f5fff guibg=White      
hi StatusLineNC	ctermbg=Black ctermfg=Blue              guifg=#5f5fff guibg=Black      
hi Title      ctermfg=DarkMagenta                       gui=bold guifg=Magenta
hi VertSplit  cterm=reverse	                            gui=reverse guifg=#dddddd guibg=#222222
hi Visual     ctermbg=NONE	cterm=reverse               gui=reverse guibg=NONE
hi VisualNOS  cterm=underline,bold                      gui=underline,bold
hi WarningMsg ctermfg=DarkRed                           guifg=Red
hi WildMenu   ctermfg=Black	ctermbg=Yellow              guifg=Black guibg=Yellow    
hi Directory  ctermfg=Blue ctermbg=NONE                 guifg=#5f5fff guibg=NONE    
hi CursorLine cterm=underline                           gui=underline guibg=NONE

" syntax highlighting
hi PreProc             cterm=NONE   ctermfg=DarkRed     gui=NONE    guifg=Red
hi Special             cterm=NONE   ctermfg=Red         gui=NONE    guifg=Red
hi Keyword             cterm=NONE   ctermfg=214         gui=NONE    guifg=#ffaf00
hi Define              cterm=NONE   ctermfg=167         gui=NONE    guifg=#d75f5f
hi Comment             cterm=NONE   ctermfg=55          gui=NONE    guifg=#5f00af
hi Type                cterm=NONE   ctermfg=Blue        gui=NONE    guifg=#5f5fff
hi rubySymbol          cterm=NONE   ctermfg=186         gui=NONE    guifg=#d7d787 
hi Identifier          cterm=NONE   ctermfg=250         gui=NONE    guifg=#bcbcbc 
hi rubyStringDelimiter cterm=NONE   ctermfg=196         gui=NONE    guifg=#ff0000
hi rubyInterpolation   cterm=NONE   ctermfg=White       gui=NONE    guifg=White
hi rubyPseudoVariable  cterm=NONE   ctermfg=66          gui=NONE    guifg=#5f8787
hi Constant            cterm=NONE   ctermfg=141         gui=NONE    guifg=#af87ff
hi Function            cterm=NONE   ctermfg=75          gui=NONE    guifg=#5fafff 
hi Include             cterm=NONE   ctermfg=220         gui=NONE    guifg=#ffd700 
hi Statement           cterm=NONE   ctermfg=104         gui=NONE    guifg=#8787d7 
hi String              cterm=NONE   ctermfg=187         gui=NONE    guifg=#d7d7af

hi xmlTag       cterm=NONE   ctermfg=75   gui=NONE   guifg=#5fafff
hi xmlTagName   cterm=NONE   ctermfg=75   gui=NONE   guifg=#5fafff
hi xmlEndTag    cterm=NONE   ctermfg=75   gui=NONE   guifg=#5fafff


" vim: sw=2
