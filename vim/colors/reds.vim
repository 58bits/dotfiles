" Vim color file
" Based on:	David Schweikert <dws@ee.ethz.ch>
" Last Change:	2006 Apr 30
" Updated by: Anthony Bouch <tony@58bits.com>
" Last Change: 2010 Oct 30

if has("gui_running")
    set background=dark
endif

hi clear

let colors_name = "mydelek"

" Normal should come first
" hi Normal     guifg=White  guibg=Black
" hi Cursor     guifg=bg     guibg=fg
hi Normal guifg=White guibg=Black
hi Cursor guifg=Black guibg=Yellow
hi lCursor    guifg=NONE   guibg=Cyan

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=LightBlue    guibg=LightBlue
hi DiffChange ctermbg=LightMagenta guibg=LightMagenta
hi DiffDelete ctermfg=Blue	   ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi DiffText   ctermbg=Red	   cterm=bold gui=bold guibg=Red
hi Directory  ctermfg=DarkBlue	   guifg=Blue
hi ErrorMsg   ctermfg=White	   ctermbg=DarkRed  guibg=Red	    guifg=White
hi FoldColumn ctermfg=DarkBlue	   ctermbg=Grey     guibg=Grey	    guifg=DarkBlue
hi Folded     ctermbg=Grey	   ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi IncSearch  cterm=reverse	   gui=reverse
hi LineNr     ctermfg=Blue	   guifg=#a8b3e2
hi ModeMsg    cterm=bold	   gui=bold
hi MoreMsg    ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi NonText    ctermfg=Blue	   gui=bold guifg=gray guibg=white
hi Pmenu      ctermfg=Blue   ctermbg=232       gui=bold guibg=#222222
hi PmenuSel   ctermfg=193	   ctermbg=233  guifg=#d7afff  guibg=Black
hi Question   ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi Search     ctermfg=NONE	   ctermbg=240 guibg=#585858 guifg=NONE
hi SpecialKey ctermfg=DarkBlue	   guifg=Blue
hi StatusLine cterm=bold	   ctermbg=blue ctermfg=White guibg=gold guifg=blue
hi StatusLineNC	cterm=bold	   ctermbg=blue ctermfg=black  guibg=gold guifg=blue
hi Title      ctermfg=DarkMagenta  gui=bold guifg=Magenta
hi VertSplit  cterm=reverse	   gui=reverse
hi Visual     ctermbg=NONE	   cterm=reverse gui=reverse guifg=Grey guibg=fg
hi VisualNOS  cterm=underline,bold gui=underline,bold
hi WarningMsg ctermfg=DarkRed	   guifg=Red
hi WildMenu   ctermfg=Black	   ctermbg=Yellow    guibg=Yellow guifg=Black

" syntax highlighting
hi Comment             cterm=NONE ctermfg=Magenta     gui=NONE guifg=magenta3
hi Constant            cterm=NONE ctermfg=193         gui=NONE guifg=#f5f4cd
hi Identifier          cterm=NONE ctermfg=Cyan        gui=NONE guifg=cyan4
hi PreProc             cterm=NONE ctermfg=DarkRed     gui=NONE guifg=red
hi Special             cterm=NONE ctermfg=Red         gui=NONE guifg=deeppink
hi Statement           cterm=bold ctermfg=Blue	      gui=bold guifg=#a8b3e2
hi Define              cterm=bold ctermfg=81          gui=bold guifg=#5fd7ff
hi Type	               cterm=NONE ctermfg=Blue	      gui=bold guifg=blue

hi Keyword             cterm=NONE ctermfg=214                  guifg=#FF6600
hi Define              cterm=NONE ctermfg=167         gui=NONE guifg=#FF6600
hi Comment             cterm=NONE ctermfg=Magenta                   guifg=#9933CC
hi Type                cterm=NONE ctermfg=Blue       gui=NONE guifg=White
hi rubySymbol          cterm=NONE ctermfg=186          gui=NONE guifg=#339999 
hi Identifier          cterm=NONE ctermfg=250       gui=NONE guifg=White 
hi rubyStringDelimiter cterm=NONE ctermfg=196         gui=NONE guifg=#66FF00
hi rubyInterpolation  cterm=NONE ctermfg=White       gui=NONE guifg=White
hi rubyPseudoVariable  cterm=NONE ctermfg=66          gui=NONE guifg=#339999
hi Constant            cterm=NONE ctermfg=141         gui=NONE guifg=#FFEE98
hi Function            cterm=NONE ctermfg=75         gui=NONE guifg=#FFCC00 
hi Include             cterm=NONE ctermfg=220         gui=NONE guifg=#FFCC00 
hi Statement           cterm=NONE ctermfg=104         gui=NONE guifg=#FF6600 
hi String              cterm=NONE ctermfg=187          gui=NONE guifg=#66FF00
hi Search              cterm=NONE ctermfg=White       gui=NONE guibg=White






" vim: sw=2
