local utils = require("config.utils")

-- Move cursor up and down by display lines
utils.map("i", "<Down>", "<C-o>gj")
utils.map("i", "<Up>", "<C-o>gk")
utils.map("n", "<Down>", "gj")
utils.map("n", "<Up>", "gk")

-- Jump by 4 lines when holding Ctrl and pressing Up/Down arrows
utils.map("i", "<C-Down>", "<C-o>5gj")
utils.map("i", "<C-Up>", "<C-o>5gk")
utils.map("n", "<C-Down>", "5gj")
utils.map("n", "<C-Up>", "5gk")
utils.map("v", "<C-Down>", "5gj")
utils.map("v", "<C-Up>", "5gk")

-- Delete the previous word
utils.map("c", "<C-H>", "<C-w><C-l>")
utils.map("i", "<C-H>", "<C-w>")

-- Insert from the system clipboard
utils.map("i", "<C-v>", "<C-r><C-p>+")

-- Write the current buffer
utils.map("i", "<C-s>", "<Esc><C-s>")
utils.map("n", "<C-s>", ":silent write <cr>")

-- Close the current buffer
utils.map("n", "<C-q>", ":quit <cr>")

-- Search the word under the cursor
utils.map("n", "<C-f>", "*")

-- Unbind the `S` and `s` keys
utils.map("n", "S", "<Nop>")
utils.map("n", "s", "<Nop>")
utils.map("v", "s", "<Nop>")

-- Change indentation using Tab
utils.map("n", "<S-Tab>", "<<")
utils.map("n", "<Tab>", ">>")
utils.map("v", "<S-Tab>", "<gv")
utils.map("v", "<Tab>", ">gv")

-- Jump through the jump list
utils.map("n", "<leader>q", "<C-o>")
utils.map("n", "<leader>e", "<C-i>")

-- Change and delete into the black hole register
utils.map("n", "c", "\"_c")
utils.map("n", "C", "\"_C")
utils.map("n", "d", "\"_d")
utils.map("n", "D", "\"_D")
utils.map("x", "c", "\"_c")
utils.map("x", "d", "\"_d")
utils.map("x", "p", "pgvy")

-- Toggle line wrapping
utils.map("n", "<A-w>", function()
  vim.o.wrap = not vim.o.wrap
end)

-- Close all buffers but this one
utils.map("n", "<A-/>", ":%bd|:e#|:bd# <cr>")

-- Map <C-Leftmouse> to <LeftMouse>
utils.map("n", "<C-LeftMouse>", "<LeftMouse>")

-- Move the lines in visual mode
-- with automatic indentation
utils.map("v", "<A-Down>", ":m '>+1<CR>gv=gv")
utils.map("v", "<A-Up>", ":m '<-2<CR>gv=gv")

-- Leave the cursor in the same place
-- while appending lines
utils.map("n", "J", "mzJ`z")

local M = {}

M.on_lsp_attach = function(_, bufnr)
  local bmap = utils.bmap(bufnr)

  bmap("n", "<C-S-s>", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
    vim.cmd(":silent write")
  end)
  bmap("n", "gR", vim.lsp.buf.rename)
  bmap("n", "gS", vim.lsp.buf.document_symbol)
  bmap("n", "ga", vim.lsp.buf.code_action)
  bmap("n", "gd", vim.lsp.buf.definition)
  bmap("n", "gh", vim.lsp.buf.hover)
  bmap("n", "gs", vim.lsp.buf.signature_help)
  bmap("n", "gw", vim.lsp.buf.workspace_symbol)
  bmap("n", "<leader>s", function()
    require("telescope.builtin").lsp_document_symbols()
  end)
  bmap("n", "<leader>S", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols()
  end)
  bmap("n", "<A-c>", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end)
end

return M
