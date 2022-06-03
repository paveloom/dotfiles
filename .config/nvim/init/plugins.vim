call plug#begin()

" Auxiliary Lua modules
Plug 'nvim-lua/plenary.nvim'

" Continuously updated session files
Plug 'tpope/vim-obsession'

" Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" Vim plugin that enables surfing through
" buffers based on viewing history per window
Plug 'ton/vim-bufsurf'

" Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Treesitter powered spellchecker
Plug 'lewis6991/spellsitter.nvim'

" Fix CursorHold Performance
Plug 'antoinemadec/FixCursorHold.nvim'

" Fundamental plugin to handle Nerd Fonts in Vim
Plug 'lambdalisue/nerdfont.vim'

" A minimal, stylish and customizable
" statusline for Neovim written in Lua
Plug 'feline-nvim/feline.nvim'

" Provides the branch name of the current git repository
Plug 'itchyny/vim-gitbranch'

" A highly extendable fuzzy finder over lists
Plug 'nvim-telescope/telescope.nvim'

" Projects Management extension for Telescope
Plug 'nvim-telescope/telescope-project.nvim'

" File Browser extension for Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Asynchronously display the colours from colours codes
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Lua fork of `vim-web-devicons` for Neovim
Plug 'kyazdani42/nvim-web-devicons'

" A file explorer tree for Neovim written in Lua
Plug 'kyazdani42/nvim-tree.lua'

" Git integration for buffers
Plug 'lewis6991/gitsigns.nvim'

" A collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" VSCode-like pictograms for Neovim LSP completion items
Plug 'onsails/lspkind-nvim'

" A completion framework
Plug 'hrsh7th/nvim-cmp'

" Snippet plugin for Vim/Nvim that supports LSP/VSCode's snippet format
Plug 'hrsh7th/vim-vsnip'

" An `nvim-cmp` source for Neovim builtin LSP client
Plug 'hrsh7th/cmp-nvim-lsp'

" An `nvim-cmp` source for buffer words
Plug 'hrsh7th/cmp-buffer'

" An `nvim-cmp` source for path
Plug 'hrsh7th/cmp-path'

" An `nvim-cmp` source for Vim's cmdline
Plug 'hrsh7th/cmp-cmdline'

" `nvim-cmp` source for `vim-vsnip`
Plug 'hrsh7th/cmp-vsnip'

" Tools for better development in Rust using Neovim's builtin LSP
Plug 'simrat39/rust-tools.nvim'

" Vim support for Julia
Plug 'JuliaEditorSupport/julia-vim'

" A Neovim plugin that helps managing crates.io dependencies
Plug 'saecki/crates.nvim'

" A modern Vim and Neovim filetype plugin for LaTeX files
Plug 'lervag/vimtex'

" Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
Plug 'jose-elias-alvarez/null-ls.nvim'

" Initialize plugin system
call plug#end()

" Plugins' configuration
source $VIM_PLUGINS/crates.vim
source $VIM_PLUGINS/feline.vim
source $VIM_PLUGINS/gitsigns.vim
source $VIM_PLUGINS/null-ls.vim
source $VIM_PLUGINS/nvim-cmp.vim
source $VIM_PLUGINS/nvim-tree.vim
source $VIM_PLUGINS/rust-tools.vim
source $VIM_PLUGINS/spellsitter.vim
source $VIM_PLUGINS/telescope.vim
source $VIM_PLUGINS/treesitter.vim
source $VIM_PLUGINS/vim-hexokinase.vim
source $VIM_PLUGINS/vim-rooter.vim
source $VIM_PLUGINS/vimtex.vim
