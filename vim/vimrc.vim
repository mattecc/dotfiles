
if has("win32")
    let DROPBOX=$USERPROFILE . "/Dropbox/"
    let CUR_PRJ=$PRJ . "/" . $PRJ
    set backupdir=c:\\temp,c:\\tmp
    set directory=c:\\temp,c:\\tmp
else
    let DROPBOX="~/Dropbox/"
    set backupdir=~/tmp,/var/tmp,/tmp
    set directory=~/tmp,/var/tmp,/tmp
endif
let DV=DROPBOX . "dotfiles/vim/"

" Pathogen (must come early)
let &rtp=DV . "," . &rtp . "," . DV . "after"
call pathogen#incubate()
call pathogen#helptags()

" Tabs and indenting
let WIDTH=4
let &tabstop=WIDTH
let &shiftwidth=WIDTH
let &softtabstop=WIDTH
set expandtab
set autoindent
set smartindent
set cindent

" Search
set hls
set incsearch
"set ignorecase
"set smartcase

" Backspace
set backspace=indent,eol,start

" Splitting preferences
set splitbelow
set splitright

" Columns and Size -- Enforce minimum height and width
"set wh=20
"set wiw=84
"set winminheight=10
"set winminwidth=20
set colorcolumn=80

filetype plugin indent on

" Line Numbers (F12 toggles)
set number
set numberwidth=4
set autowrite
nnoremap <F12> :set nonumber!<CR>:set foldcolumn=0<CR>

" NERDTree (F11 toggles)
nnoremap <F11> :NERDTreeToggle<CR>

" Folding (space toggles)
set foldmethod=indent
set foldlevel=99
nnoremap <space> zA
vnoremap <space> zF

" GVim options
if has("gui_running")
    " Maximize on startup (gvim)
    if has("win32")
        au GUIEnter * simalt ~x
    elseif has("gui_macvim")
        set fullscreen
        nmap <SwipeLeft> :bN<CR>
        nmap <SwipeRight> :bn<CR>
    endif

    " Hide gvim chrome
    set guioptions -=m  " Menu
    set guioptions -=T  " Toolbar
    set guioptions -=r  " Scrollbar
    set guioptions -=R  " Scrollbar
    set guioptions -=l  " Scrollbar
    set guioptions -=L  " Scrollbar
    set guioptions -=b  " Scrollbar
endif

" Tab complete stuff
let g:SuperTabDefaultCompetionType = "context"
set completeopt=menuone,longest,preview
inoremap <C-Space> <C-x><C-o>
set wildmenu
set wildmode=list:longest

"  Ctrl-WoW Strafe keys moves through buffers
nnoremap <C-s> :bprev<CR>
nnoremap <C-f> :bnext<CR>

" Ctrl-VI Keys moves focus window within VIM
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

" Alt-VI keys moves through error lists
" XXX: Figure out Mac binding strategy
nnoremap <A-j> :cn<CR>
nnoremap <A-k> :cp<CR>

" TComment
" <c-_><c-_> TComment
" <c-_>i TCommentInline
" <c-_>r TCommentRight
" <c-_>*

" Colors and style
colo wow
syntax on


" vim:syntax=vim
