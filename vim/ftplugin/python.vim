" ------------
" Python stuff
" ------------

" F1 - <VIM HELP>
" F2 - *open*
" F3 - *open*
" F4 - Update Tags
" F5 - Pep8 Checker
" F6 - Run % with Python
" F7 - Toggle Breakpoint
" F8 - Toggle Taglist
" F9 - ?
" F10 - ?
" F11 - <NERDTree>
" F12 - <Toggle Line #>

if has("win32")
    let PY_ENV=$VIRTUAL_ENV
else
    let PY_ENV="" "XXX: Fix me on Mac/Linux
endif

"  Tags 
let &tags=CUR_PRJ . "/tags," . PY_ENV . "/tags," . "./tags;/"
function! UpdateTags()
    execute ":!ctags -R --python-kinds=-i"
    echohl StatusLine | echo "Python tag updated" | echohl None
endfunction
nnoremap <F4> :call UpdateTags()<CR>
nnoremap <F8> :TlistToggle<CR>
" XXX: Tlist Options are not working
"let g:Tlist_Auto_Open=1
"let g:Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Highlight_Tag_On_BufEnter=1
"let Tlist_WinWidth

" Run file via python (useful on Windows only?)
nnoremap <F6>!python %<CR>

" PyDoc Configuration
" Usage: :Pydoc foo
"        <Leader>pw -- current word
"        XXX: Would like to remap current word to F-key, but not working
let g:pydoc_cmd='python -m pydoc'  " So it doesn't need to be in path
"let g:pydoc_open_cmd='vsplit'      " Use a vertical split
let g:pydoc_use_drop=1             " Re-use an open pydoc window if available
let g:pydoc_highlight=0           " Don't highlight the search term

" Python :make
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Tab completion stuff
set omnifunc=pythoncomplete#Complete

" XXX: fugitive
"
" Things to figure out
" - Rope (jump to definitions, rename etc.)
" - Use "find" style opens C-T?

" Virtualenv setup
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
   project_base_dir = os.environ['VIRTUAL_ENV']
   sys.path.insert(0, project_base_dir)
   activate_this = os.path.join(project_base_dir, 'Scripts/activate_this.py')
   execfile(activate_this, dict(__file__=activate_this))
EOF

"
" Import statement jumping via 'gf'
python << EOF
import os
import sys
import vim
for p in sys.path:
   if os.path.isdir(p):
      vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" " Execute a selection of code (very cool!)
" " Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
" map <C-h> :py EvaluateCurrentRange()

" F7/Shift-F7 to add/remove a breakpoint (pdb.set_trace)
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 5}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 1)
        vim.command( 'normal j1')

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:15] == "pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "map <s-f7> :py RemoveBreakpoints()<cr>")
EOF
