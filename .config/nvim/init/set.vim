" Enable relative numbers for lines, but
" show the absolute number for the current line
set number
set relativenumber

" Set the font
set guifont=FiraCode\ Nerd\ Font:h13

" Allow the cursor to move to the
" upper line when pressing Left
set whichwrap+=<,>,[,]

" Make some of the invisible characters visible
set list
set listchars+=tab:▸\ ,

" Always expand tabs
set expandtab

" Enable smart indentation
set smartindent

" Allow the mouse usage
set mouse=a

" Use the clipboard register '+' instead of
" register '*' for all yank, delete, change
" and put operations
set clipboard+=unnamedplus

" Set what to save in a session
set sessionoptions=blank,buffers,curdir,folds,
                  \help,tabpages,winsize,winpos,terminal

" Don't wrap the lines by default
set nowrap

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let &undodir = expand($VIM_DATA . '/.undodir')
  call mkdir(&undodir , 'p')
  set undofile
endif

" Enable the sign column
set signcolumn=yes

" Enable 24-bit RGB color in the TUI
set termguicolors

" Enable spell checking
set spell
set spelllang=en,ru

" Set an alternative keyboard mapping to Russian
set keymap=russian-jcukenwin
:set iminsert=0 imsearch=-1

" Set completion options
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Set a delay for CursorHold events
set updatetime=300
