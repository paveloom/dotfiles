local o = vim.opt

local utils = require("config.utils")

-- Set the leader key
vim.g.mapleader = " "

-- Show line numbers
o.number = true

-- Highlight the number of the current line
o.cursorline = true
o.cursorlineopt = "both"

-- Don't time out on key codes (leader, specifically)
o.timeout = false
o.ttimeout = false

-- Define special characters for vertical separators
o.fillchars:append({ fold = " ", foldopen = "▼", foldsep = "│", foldclose = "▸" })

-- Don't close folds by default
o.foldlevel = 99

-- Allow the cursor to move to the upper line when pressing Left
o.whichwrap:append({ ["<"] = true, [">"] = true, ["["] = true, ["]"] = true })

-- Make some of the invisible characters visible
o.list = true
o.listchars:append({ tab = "▸ " })

-- Always expand tabs
o.expandtab = true

-- Set the default number of spaces inserting with a <Tab>
o.shiftwidth = 2

-- Enable smart indentation
o.cindent = true

-- Allow the mouse usage
o.mouse = "a"

-- Don't wrap the lines by default
o.wrap = false

-- Wrap at a word boundary
o.linebreak = true

-- Keep undo history
o.undofile = true

-- Always show the sign column
o.signcolumn = "yes"

-- Enable 24-bit RGB color in the TUI
o.termguicolors = true

-- Enable spell checking
o.spell = true
utils.add_lang("ru")

-- Set an alternative keyboard mapping to Russian
o.keymap = "russian-jcukenwin"
o.iminsert = 0

-- Set completion options
o.completeopt = { "menuone", "preview", "noinsert", "noselect" }

-- Use more abbreviations in the command-line and truncate when necessary
o.shortmess = { a = true, c = true, T = true, F = true }

-- Set a delay for CursorHold events
o.updatetime = 300

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Make searching case insensitive
o.ignorecase = true
o.smartcase = true

-- Do all yank, delete, and put operations in system clipboard
o.clipboard = "unnamedplus"
