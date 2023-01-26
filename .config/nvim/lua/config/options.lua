local utils = require("config.utils")

-- Set the leader key
vim.g.mapleader = " "

-- Show line numbers
vim.opt.number = true

-- Highlight the number of the current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- Don't time out on key codes (leader, specifically)
vim.opt.timeout = false
vim.opt.ttimeout = false

-- Define special characters for vertical separators
vim.opt.fillchars:append({ fold = " ", foldopen = "▼", foldsep = "│", foldclose = "▸" })

-- Don't close folds by default
vim.opt.foldlevel = 99

-- Allow the cursor to move to the upper line when pressing Left
vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, ["["] = true, ["]"] = true })

-- Make some of the invisible characters visible
vim.opt.list = true
vim.opt.listchars:append({ tab = "▸ " })

-- Always expand tabs
vim.opt.expandtab = true

-- Set the default number of spaces inserting with a <Tab>
vim.opt.shiftwidth = 2

-- Enable smart indentation
vim.opt.cindent = true

-- Indent wrapped lines, too
vim.opt.breakindent = true

-- Allow the mouse usage
vim.opt.mouse = "a"

-- Don't wrap the lines by default
vim.opt.wrap = false

-- Wrap at a word boundary
vim.opt.linebreak = true

-- Keep undo history
vim.opt.undofile = true

-- Always show the sign column
vim.opt.signcolumn = "yes"

-- Enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Enable spell checking
vim.opt.spell = true
utils.add_lang("ru")

-- Set an alternative keyboard mapping to Russian
vim.opt.keymap = "russian-jcukenwin"
vim.opt.iminsert = 0

-- Set completion options
vim.opt.completeopt = { "menuone", "preview", "noinsert", "noselect" }

-- Use more abbreviations in the command-line and truncate when necessary
vim.opt.shortmess = {
  F = true,
  I = true,
  T = true,
  W = true,
  a = true,
  c = true,
  s = true,
}

-- Set a delay for CursorHold events
vim.opt.updatetime = 300

-- Number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- Make searching case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Do all yank, delete, and put operations in system clipboard
vim.opt.clipboard = "unnamedplus"

-- Don't resize windows after closing one
vim.opt.equalalways = false
