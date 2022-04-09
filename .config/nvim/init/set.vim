" Enable relative numbers for lines, but
" show the absolute number for the current line
set number
set relativenumber

" Highlight the number of the current line
set cursorline
set cursorlineopt=number

" Don't time out on key codes (leader, specifically)
set notimeout
set nottimeout

" Create folds automatically based on indentation
set foldmethod=indent
set foldlevel=99
set fillchars+=fold:\ ,foldopen:▼,foldsep:│,foldclose:▸

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

" Set what to save in a session
set sessionoptions=blank,buffers,folds,
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
set iminsert=0 imsearch=-1

" Set completion options
set completeopt=menuone,noinsert,noselect

" Use more abbreviations in the command-line and truncate when necessary
set shortmess=acTF

" Set a delay for CursorHold events
set updatetime=300
