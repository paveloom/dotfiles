" Restore the session when entering Vim (function)
function! RestoreSession()
  " Restore the session
  if filereadable($VIM_SESSION)
    source $VIM_SESSION
  endif
  " Start recording the session
  Obsession $VIM_SESSION
endfunction

" Restore the session when entering Vim (autocmd)
autocmd VimEnter * ++nested silent call RestoreSession()

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
