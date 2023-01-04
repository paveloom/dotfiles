local utils = require("config.utils")

local cmap = utils.cmap
local imap = utils.imap
local nmap = utils.nmap
local vmap = utils.vmap
local xmap = utils.xmap

-- Jump by 4 lines when holding Ctrl and pressing Up/Down arrows
imap("<C-Down>", "<C-o>5j")
imap("<C-Up>", "<C-o>5k")
nmap("<C-Down>", "5j")
nmap("<C-Up>", "5k")
vmap("<C-Down>", "5j")
vmap("<C-Up>", "5k")

-- Delete the previous word
cmap("<C-h>", "<C-w><C-l>")
imap("<C-h>", "<C-w>")

-- Insert from the system clipboard
imap("<C-v>", "<C-r><C-p>+")

-- Write the current buffer
imap("<C-s>", "<Esc><C-s>")
nmap("<C-s>", ":silent write <cr>")

-- Close the current buffer
nmap("<C-q>", ":quit <cr>")

-- Search the word under the cursor
nmap("<C-f>", "*")

-- Change indentation using Tab
nmap("<S-Tab>", "<<")
nmap("<Tab>", ">>")
vmap("<S-Tab>", "<gv")
vmap("<Tab>", ">gv")

-- Jump through the jump list
nmap("<leader>q", "<C-o>")
nmap("<leader>e", "<C-i>")

-- Change and delete into the black hole register
nmap("c", "\"_c")
nmap("C", "\"_C")
nmap("d", "\"_d")
nmap("D", "\"_D")
xmap("c", "\"_c")
xmap("d", "\"_d")
xmap("p", "pgvy")

-- Toggle line wrapping
nmap("<A-w>", function()
  vim.o.wrap = not vim.o.wrap
end)

-- Close all buffers but this one
nmap("<A-/>", ":%bd|:e#|:bd# <cr>")

-- Map <C-Leftmouse> to <LeftMouse>
nmap("<C-LeftMouse>", "<LeftMouse>")

-- Move the lines in visual mode
-- with automatic indentation
vmap("<A-Down>", ":m '>+1<CR>gv=gv")
vmap("<A-Up>", ":m '<-2<CR>gv=gv")

-- Leave the cursor in the same place
-- while appending lines
nmap("J", "mzJ`z")
