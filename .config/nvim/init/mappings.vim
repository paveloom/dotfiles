" Jump by 4 lines when holding Ctrl and pressing Up/Down arrows
nnoremap <silent> <C-Up> 5k
nnoremap <silent> <C-Down> 5j
inoremap <silent> <C-Up> <C-o>5k
inoremap <silent> <C-Down> <C-o>5j

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

" Always cut, yank and paste from the clipboard
nnoremap y "+y
nnoremap p "+p
vnoremap y "+y
vnoremap p "+p
vnoremap x "+x

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
        lua vim lsp.buf.hover()
    endif
endfunction

" General hover action (shortcut)
nnoremap <silent> <C-h> :call <SID>HoverAction()<cr>

" Code actions and navigation
nnoremap <silent> g, :lua vim.diagnostic.goto_prev() <cr>
nnoremap <silent> g. :lua vim.diagnostic.goto_next() <cr>
nnoremap <silent> gD :Gitsigns diffthis <cr>
nnoremap <silent> gR :lua vim.lsp.buf.rename() <cr>
nnoremap <silent> gS :lua vim.lsp.buf.document_symbol() <cr>
nnoremap <silent> ga :lua vim.lsp.buf.code_action() <cr>
nnoremap <silent> gd :lua vim.lsp.buf.definition() <cr>
nnoremap <silent> gi :lua vim.lsp.buf.implementation() <cr>
nnoremap <silent> gk :Gitsigns prev_hunk <cr>
nnoremap <silent> gl :Gitsigns next_hunk <cr>
nnoremap <silent> gr :lua vim.lsp.buf.references() <cr>
nnoremap <silent> gs :lua vim.lsp.buf.signature_help() <cr>
nnoremap <silent> gt :lua vim.lsp.buf.type_definition() <cr>
nnoremap <silent> gw :lua vim.lsp.buf.workspace_symbol() <cr>

" Telescope
nnoremap <silent> <leader>f :Telescope find_files <cr>
nnoremap <silent> <leader>g :Telescope live_grep <cr>
nnoremap <silent> <leader>b :Telescope buffers <cr>
nnoremap <silent> <leader>p :lua require('telescope').extensions.project.project{ display_type = 'full' } <cr>
nnoremap <silent> <leader>n :Telescope file_browser <cr>

" Buffer history navigation
nnoremap <silent> <leader>a :BufSurfBack <cr>
nnoremap <silent> <leader>d :BufSurfForward <cr>

" Close all buffers but this one
nnoremap <silent> <A-/> :%bd\|:e#\|:bd# <cr>
