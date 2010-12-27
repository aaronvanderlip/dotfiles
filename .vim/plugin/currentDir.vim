function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    if isdirectory(_dir)
      exec "cd " . escape(_dir, ' ')
    endif
    unlet _dir
endfunction

autocmd BufEnter * call CHANGE_CURR_DIR() 
