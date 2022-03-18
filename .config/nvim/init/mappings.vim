" Open the `init.vim` file
nnoremap <silent> <leader>p :e $MYVIMRC <cr>

" Write the current buffer
nnoremap <silent> <C-s> :silent write <cr>
inoremap <silent> <C-s> <Esc><C-s>

" Close the current buffer
nnoremap <silent> <C-q> :q <cr>

" Change indentation using Tab
nnoremap <silent> <Tab> >>
nnoremap <silent> <S-Tab> <<
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" Jump through the jump list
nnoremap <leader>q <C-o>
nnoremap <leader>e <C-i>

" Toggle line numbering
nnoremap <silent> <A-n> :set invrelativenumber <cr>

" Toggle line wrapping
nnoremap <silent> <A-w> :set invwrap <cr>

" Toggle spell checking
nnoremap <silent> <A-s> :set invspell <cr>

" General hover action (function)
function! s:HoverAction()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (index(['man'], &filetype) >= 0)
        execute 'Man '.expand('<cword>')
    elseif (expand('%:t') == 'Cargo.toml')
        lua require('crates').show_popup()
    else
        lua vim.lsp.buf.hover()
    endif
endfunction

" General hover action (shortcut)
nnoremap <silent> <C-h> :call <SID>HoverAction()<cr>

" Code navigation
nnoremap <silent> g, <cmd>lua vim.diagnostic.goto_prev() <cr>
nnoremap <silent> g. <cmd>lua vim.diagnostic.goto_next() <cr>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action() <cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition() <cr>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation() <cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references() <cr>
nnoremap <silent> gS <cmd>lua vim.lsp.buf.document_symbol() <cr>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition() <cr>
nnoremap <silent> gw <cmd>lua vim.lsp.buf.workspace_symbol() <cr>
nnoremap <silent> gR <cmd>lua vim.lsp.buf.rename() <cr>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help() <cr>

" Telescope
nnoremap <silent> <leader>f :Telescope find_files <cr>
nnoremap <silent> <leader>g :Telescope live_grep <cr>
nnoremap <silent> <leader>b :Telescope buffers <cr>

" Buffer history navigation
nnoremap <silent> <leader>a :BufSurfBack <cr>
nnoremap <silent> <leader>d :BufSurfForward <cr>

" Close all buffers but this one
nnoremap <silent> <A-/> :%bd\|:e#\|:bd# <cr>
