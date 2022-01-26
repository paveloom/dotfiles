" Save the session when entering a buffer (function)
function! BufEnterSaveSession()
  " Don't save the session until Vim finished entering
  if v:vim_did_enter
    mksession! $VIM_SESSION
  endif
endfunction

" Save the session when leaving Vim (function)
function! VimLeaveSaveSession()
  " Find and close the file explorer
  execute 'bdelete! ' . bufnr('NvimTree')
  mksession! $VIM_SESSION
endfunction

" Restore the session when entering Vim (function)
function! RestoreSession()
  if filereadable($VIM_SESSION)
    source $VIM_SESSION
    NvimTreeFindFile
  endif
endfunction

" Save the session when entering a buffer (autocmd)
autocmd BufEnter * call BufEnterSaveSession()

" Save the session when leaving Vim (autocmd)
autocmd VimLeavePre * call VimLeaveSaveSession()

" Restore the session when entering Vim (autocmd)
autocmd VimEnter * ++nested call RestoreSession()

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Remove trailing lines containing whitespace
autocmd BufWritePre * :%s/\($\n\s*\)\+\%$//e

" Set `shiftwidth' per file type
autocmd FileType vim setlocal shiftwidth=2

" Show a diagnostic pop-up on cursor hold with a 300 ms delay
set updatetime=300
autocmd CursorHold *.rs lua vim.diagnostic.open_float(nil, { focusable = false })

" Format on save
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
