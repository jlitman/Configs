"The system wide vimrc is /usr/share/vim/vim61/macros/vimrc
"so $VIMRUNTIME/vimrc_example.vim

if has('win32')
"include this file if you are on Windows so you can use the standard
"Cut/Copy/Paste keys and access the system clipboard
source $VIMRUNTIME/mswin.vim
else
    "this lets you type :Man topic to get the man page for topic
    source $VIMRUNTIME/ftplugin/man.vim
endif

"Note on Ubuntu, VIMRUNTIME is not defined. Instead Vim is defined as
"/usr/share/vim. In that directory, are links to the system vim rc files. This
"is a better system since you don't have to change your vimrc everytime vim
"gets updated (which changes VIMRUNTIME).

"set options
set nocompatible
set bs=2
set ruler
set nobackup
set expandtab
set autoindent 
set cindent
set tw=78 "set the width of text to 78
set ts=4
set laststatus=2
set showmatch
set shiftwidth=4
syntax on 

set nohls

"The next three lines get rid of error bells and flashing
"The set t_vb= MUST also go into a .gvimrc or you will still get flashing in
"gvim
set noeb "no error bell
set vb "this plus next line gets rid of visual bell
set novb
set t_vb= 
set makeprg=make\ %< "call make with the base name of the file as an arg
set noincsearch "I hate incremental search

"set incsearch "incremental search
set wildmenu
set showmatch

"set guifont=courier_new:h11 "this is how to do it
set cm=blowfish

if ($COLORTERM == " ") || ($COLORTERM == "mate-terminal") || empty($COLORTERM)
    set bg=dark
endif

"define abbreviations
iab PY #!/usr/bin/python
iab namepsace namespace
iab reutrn return;
iab THis This
iab THe The
iab YDATE <C-R>=strftime("%B %d, %Y %I:%M %p")<CR>
iab YLOG <ESC>79i=<ESC>i<CR>CYDATE<CR><ESC>
iab satte state
iab Satte State

"fix backspace
if &term == "rxvt"
	set t_kb=
endif

let vimrc='~\.vimrc'
"reload vimrc
nn ,u :source <C-R>=vimrc<CR><CR>
"edit vimrc
nn ,v :edit <C-R>=vimrc<CR><CR>

"define maps and functions
"toggle search highlighting
map <F7> :set hls!<CR>:set hls?<CR>

"toggle case sensitive search
map <F6> : set ic!<CR>:set ic?<CR>

"insert C style comment
map ,com i/**/<ESC>1hi

"display date/time in status area
map ,t :echo strftime("%c")<CR>

"In insert mode press Ctrl-F to make the word before the cursor uppercase
map! <C-F> <Esc>gUiw`]a

imap jj <ESC>

"from http://www.highley-recommended.com/text-processing.html
"integrate aspell spelling checker
set autowrite
map <Leader>s <Esc>:!aspell -c --dont-backup "%"<CR>:e! "%"<CR><CR>
                                                                                
"from vim tips rss feed on 6/4/2005
"requires viminterpreter shell script
map ,p :w !viminterpreter python <CR>
																				"from http://vim.sourceforge.net/tips/tip.php?tip_id=790
autocmd BufReadPre *.doc set ro
"autocmd BufReadPre *.doc set hlsearch!
"autocmd BufReadPost *.doc %!antiword %"%"
autocmd BufReadPost *.doc %!antiword %
																				
"try to do the same as above with pdf
autocmd BufReadPre *.pdf set ro
autocmd BufreadPost *.pdf %!pdftotext -layout "%" -

"from http://py.vaults.ca/~x/python_and_vim.html
"make vim do python indent smarter
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class


"from vim tips
"F9 moves you back one buffer, F10 moves you forward one buffer
map <F9> :previous^M
map <F10> :next^M

"automatically put closing braces and curlys
inoremap ( ()<LEFT>
autocmd BufReadPre *.c inoremap { {}<LEFT><RETURN><RETURN><UP><TAB> 
autocmd BufReadPre *.cpp inoremap { {}<LEFT><RETURN><RETURN><UP><TAB> 

"in makefiles, don't expand tabs to spaces, since actual tab characters are
"needed, and have indentation at 8 chars to be sure that all indents are tabs
"(despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

"make the explore window split vertically
let g:explVertical=1
let g:explSplitRight=1

"This function uses ctags to get a list of functions in a c file.
"The list is put into the quickfix window (cwindow) and is clickable.
"Invoke it with :call ShowFunc (or map it=> :nmap <somekey> :call
"ShowFunc()<CR>
"I got this from http://vim.sourceforge.net
function! ShowFunc() 
     
    let gf_s = &grepformat 
    let gp_s = &grepprg 

    let &grepformat = '%*\k%*\sfunction%*\s%l%*\s%f %*\s%m' 
    let &grepprg = 'ctags -x --c-types=f --sort=no -o -' 

    update "write 
    silent! grep % 
    cwindow 

    let &grepformat = gf_s 
    let &grepprg = gp_s 

endfunc 

"used by ,x macros to do a grep on the word under the cursor in the current
"dir in files matching the grep_ext
"""let grep_ext = "*"
"using turbo grep from Borland i=ignore case, o=Unix format, n=show line
"number
"""set grepprg=grep\ -ino
"v=visual mode per char iw=ineer word y=yank "=put what was yanked
"""map ,x viwy:grep <C-R>" <C-R>=expand("%:p:h")<CR>\*.<c-r>=grep_ext<CR><CR>

"I needed to put #if/#endif around some code so...
"Put the cursor on the line you want "surrounded" and run this
map ,m <ESC>k$a<CR>#if NETXRAY<ESC>j$a<CR>#endif
" k moves up a line $ moves to the end of the line a appends
" j moves down a line
"NOTE this does NOT work if the line to be surrounded is the first line
