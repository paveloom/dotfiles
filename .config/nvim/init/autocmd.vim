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
autocmd FileType vim,markdown,tex,html setlocal shiftwidth=2
autocmd FileType sh,julia setlocal shiftwidth=4

" Show a diagnostic pop-up on CursorHold
autocmd CursorHold *.rs lua vim.diagnostic.open_float(nil, { focusable = false })

" Format on save
autocmd BufWritePre *.rs,*.html lua vim.lsp.buf.formatting_sync(nil, 2000)

" Highlight a yanked region
autocmd TextYankPost * lua vim.highlight.on_yank { higroup="Visual", on_visual=false }

" Compile TeX files on save
autocmd BufWritePost *.tex VimtexCompile
