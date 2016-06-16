"to get rid of the annoying flashing
set t_vb=
set viminfo='20,<50,s10,h,n$HOME/.viminfo
"set shell=c:\cygwin\bin\bash.exe
"set shell=c:\cygwin\cygwin.bat
"set shellcmdflag=--login\ -c
"set shellquote=\"

set lines=36 "set size of gvim window
set co=90    "set width of gvim window
set guioptions-=T

"From http://www.vim.org/tips/tip.php?tip_id=1235
"This only works  when vim was compiled with python support
"USe it like this :Calc 2+3 (much more complicated expressions should work)
:command! -nargs=+ Calc :py print <args>
:py from math import * 

"sets the gvim titlebar to the expansion of SystemRoot
"let &titlestring = expand("$SystemRoot")
"puts up a dialog box with the expandsion of SystemRoot
"echo expand("$SystemRoot")

"=========================================
"from Hacking Vim Sample Chapter 2
"must set spell for this to work
function! FoldSpellBalloon()
    let lines = spellsuggest(spellbadword(v:beval_text)[ 0 ], 5, 0)
    return join(lines, has("balloon_multiline") ? "\n" : "")
endfunction

set balloonexpr=FoldSpellBalloon()
set ballooneval
"===========================================
