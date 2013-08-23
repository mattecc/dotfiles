set laststatus=2

if !exists("g:sl_format")
    let g:sl_format="%=%m%r%h %y [%l,%v] %P"
    let g:sl_pad=20
    " XXX: Can g:sl_pad be calculated dynamically based on format?
endif

" 1-based Circular buffer increment / decrement
function! CircBuf(size, value, inc)
    return ((a:size + a:value - 1 + a:inc) % a:size) + 1
endfunction

function! AllBuffStr()
    let num_bufs=bufnr('$')
    let i=1
    let mystr=''
    while (i <= num_bufs)
        if buflisted(i)
            let n = fnamemodify(bufname(i), ":t")
            if i == bufnr('%')
                let mystr = mystr . '%1*'. n .'%* '
            else 
                let mystr = mystr . n . ' '
            endif
        endif
        let i=i+1
    endwhile
    return mystr
endfunction

function! MyStatusline()
    let max_len = winwidth(0) - g:sl_pad

    " Construct a basic highlighted string. If its short enough use it
    let buflist_str = AllBuffStr()
    if len(buflist_str) + 3 <= max_len
        return buflist_str . g:sl_format
    endif

    " Since we need to truncate some buffers, build out from current buffer
    " on both sides so you can see clearly next and prev buffers
    let num_bufs=bufnr('$')
    let cur_nr=bufnr('%')
    let n_nr = cur_nr
    let p_nr = cur_nr
    let buflist_str='%1*'.fnamemodify(bufname('%'),':t').'%*'
    let cur_len = len(buflist_str) - 5
    while 1
        " Increment both pointers
        let n_nr = CircBuf(num_bufs, n_nr, +1)
        let p_nr = CircBuf(num_bufs, p_nr, -1)

        " Check whether we're done with all buffers
        if (n_nr == cur_nr || p_nr == cur_nr || CircBuf(num_bufs, p_nr, +1) == n_nr)
        endif

        " Still room for next buffer?
        if (buflisted(n_nr))
            let b_name = fnamemodify(bufname(n_nr),':t')
            if (cur_len + len(b_name) > max_len)
                break
            endif

            " Append it
            let buflist_str = buflist_str . " " . b_name
            let cur_len = len(buflist_str)
        endif

        " Check whether next overlapped prev
        if (n_nr == p_nr)
            break
        endif

        " Still room for prev buffer?
        if (buflisted(p_nr))
            let b_name = fnamemodify(bufname(p_nr),':t')
            if (cur_len + len(b_name) > max_len)
                break
            endif

            " Prepend it
            let buflist_str = b_name . " " . buflist_str
            let cur_len = len(buflist_str)
        endif
    endwhile

    return "... " . buflist_str . " ..." . g:sl_format
endfunction

au BufEnter,BufNew,BufDelete,BufWinEnter * let &l:statusline=MyStatusline()
