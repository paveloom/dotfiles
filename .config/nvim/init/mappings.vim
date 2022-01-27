" Open the `init.vim` file
nnoremap <silent> <C-p> :e $MYVIMRC <cr>

" Duplicate the current buffer in a new horizontal split
nnoremap <silent> <C-h> :split <cr>

" Duplicate the current buffer in a new vertical split
nnoremap <silent> <C-v> :vsplit <cr>

" Write the current buffer
nnoremap <silent> <C-s> :silent write <cr>

" Close the current buffer
nnoremap <silent> <C-q> :q <cr>

" Change indentation using Tab
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" Toggle line wrapping (function)
function! ToggleWrap()
  if (&wrap)
    set nowrap
  else
    set wrap
  endif
endfunction

" Toggle line wrapping (shortcut)
nnoremap <silent> <A-w> :call ToggleWrap() <cr>

" Toggle spell checking (function)
function! ToggleSpell()
  if (&spell)
    set nospell
  else
    set spell
  endif
endfunction

" Toggle spell checking (shortcut)
nnoremap <silent> <A-s> :call ToggleSpell() <cr>

" Code navigation
nnoremap <silent> h <cmd>lua vim.lsp.buf.hover() <cr>
nnoremap <silent> s <cmd>lua vim.lsp.buf.signature_help() <cr>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation() <cr>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition() <cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references() <cr>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.document_symbol() <cr>
nnoremap <silent> gw <cmd>lua vim.lsp.buf.workspace_symbol() <cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition() <cr>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action() <cr>
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev() <cr>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next() <cr>

" Telescope
nnoremap <silent> f :Telescope find_files<cr>
nnoremap <silent> l :Telescope live_grep<cr>
nnoremap <silent> b :Telescope buffers<cr>

" Buffer history navigation
nnoremap <silent> <C-[> :BufSurfBack<cr>
nnoremap <silent> <C-]> :BufSurfForward<cr>
