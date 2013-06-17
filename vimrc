" based on http://github.com/jferris/config_files/blob/master/vimrc
" based on Peecode vim-full sample
" based on http://www.pixelbeat.org/settings/.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Source pathogen. In this case it's in a bundle directory and not the 
" Vim autoload directory (and is managed as a git subrepository) 
source ~/.vim/bundle/pathogen/autoload/pathogen.vim

" Now call pathogen
silent! call pathogen#infect()
" silent! call pathogen#helptags()

filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set visualbell                    " No beeping.
set nobackup			  " No automatic backups
set nowritebackup
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set history=50			  " keep 50 lines of command line history
set ruler			  " show the cursor position all the time
set showcmd			  " display incomplete commands
set showmode   			  
set incsearch			  " do incremental searching
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set nowrap			  " Switch wrap off for everything
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set cpoptions+=$                  " Places a dollar sign at the end of the 'to be' changed text.

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Numbers
set number
set numberwidth=5

" Vim-slime settings
let g:slime_target = "tmux"


"mark syntax errors with :signs
let g:syntastic_enable_signs=1

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text
  
  " Set file type for nginx configs
  autocmd BufNewFile,BufRead /etc/nginx/* set ft=nginx
  autocmd BufNewFile,BufRead /private/etc/nginx/* set ft=nginx
  autocmd BufNewFile,BufRead /usr/local/etc/nginx/* set ft=nginx

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Set tab and shitwidth settings for ruby
  autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
  
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevel=20
  set foldnestmax=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif


" Always display the status line
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""
"Will not work under Teminal.app on Mac OS X - causes certain colors and characters to 'flash'.
set t_Co=256

" syntax enable                     " Turn on syntax highlighting (compare with syntax on below)
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set incsearch                     " Highlight matches as you type
  set hlsearch                      " Highlight matches.
endif

if &diff
  "I'm only interested in diff colours
  syntax off
endif

" Color scheme
colorscheme daring-dark 
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0


"syntax highlight shell scripts as per POSIX,
"not the original Bourne shell which very few use
let g:is_posix = 1

"flag problematic whitespace (trailing and spaces before tabs)
"Note you get the same by doing let c_space_errors=1 but
"this rule really applys to everything.
"highlight RedundantSpaces term=standout ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted
"use :set list! to toggle visible whitespace on/off
set listchars=tab:>-,trail:.,extends:>


" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{exists('g:loaded_rvm')?rvm#statusline():''}%=%-16(\ %l,%c-%v\ %)%P


""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""
" \ is the leader character
let mapleader = ","

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"all Enter to be used to create a new blank line and return to normal mode.
"map <CR> O<Esc>j
"map <S-Enter> o<Esc>k

"map toggle vertical split for NERDTree
map <F2> :NERDTreeToggle<CR>

"Map spacebar to buffer explorer.
"nmap <Space> <leader>be
"
"Map spacebar to CommandTBuffer
nmap <Space> :CommandTBuffer<CR>

"CommandT command
noremap <Leader>z  :CommandT<CR>

"TComment toggle mapping
noremap <Leader>cc  :TComment<CR>

"Textile preview settings and mapping
let g:TextileBrowser="Google Chrome"
noremap <leader>pt :TextilePreview<CR>

"Markdown preview"
noremap <leader>pm :Mm<CR>

"Use CTRL-S for saving, also in Insert mode
"Requires bash$ stty -ixon -ixoff to capture Ctrl-S
noremap <C-s> :update<CR>
cnoremap <C-s> <Esc>:update<CR>
inoremap <C-s> <Esc>:update<CR>

"Map <Esc> to <Esc>`^ which will prevent the curser from moving back a space
"after leaving insert mode.
"inoremap <Esc> <Esc>`^
"Also map the backtick ' - to leave escape mode.
"inoremap ` <Esc>`^

"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X

"This is necessary to allow pasting from outside vim. It turns off auto stuff.
"You can tell you are in paste mode when the ruler is not visible
"NOTE: This has been set above at F9 - and F2 has been remapped to NERDTree
"toggle.
"set pastetoggle=<F2>


" Tab mappings.
" map <leader>tt :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>to :tabonly<cr>
" map <leader>tn :tabnext<cr>
" map <leader>tp :tabprevious<cr>
" map <leader>tf :tabfirst<cr>
" map <leader>tl :tablast<cr>
" map <leader>tm :tabmove
" imap <Tab> <C-N>
" imap <S-Tab> <C-P>
" vmap <Tab> >gv
" vmap <S-Tab> <gv
" nmap <S-Tab> <C-W><C-W>



" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Move lines up and down
map <C-J> :m +1 <CR>
map <C-K> :m -2 <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Display extra whitespace
" set list listchars=tab:»·,trail:·

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

let g:fuf_splitPathMatching=1

" Open URL
command -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

"Set F9 to toggle line numbers in normal mode
nmap <F9> :set invnumber<CR>
"Set F9 to toggle paste mode in insert mode.
set pastetoggle=<F9>

"Markdown to HTML  
nmap <Leader>md :%!/usr/local/bin/Markdown.pl --html4tags<CR>

" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
" autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif
