-- Map a keybinding
local function map(m, k, e, _options)
  local options = { silent = true }
  if _options then
    options = vim.tbl_extend("force", options, _options)
  end
  vim.keymap.set(m, k, e, options)
end

-- Map a buffer keybinding
local function new_bmap(bufnr)
  return function(m, k, e)
    map(m, k, e, {
      noremap = true,
      buffer = bufnr,
    })
  end
end

-- Move cursor up and down by display lines
map("i", "<Down>", "<C-o>gj")
map("i", "<Up>", "<C-o>gk")
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")

-- Jump by 4 lines when holding Ctrl and pressing Up/Down arrows
map("i", "<C-Down>", "<C-o>5gj")
map("i", "<C-Up>", "<C-o>5gk")
map("n", "<C-Down>", "5gj")
map("n", "<C-Up>", "5gk")
map("v", "<C-Down>", "5gj")
map("v", "<C-Up>", "5gk")

-- Delete the previous word
map("c", "<C-H>", "<C-w><C-l>")
map("i", "<C-H>", "<C-w>")

-- Insert from the system clipboard
map("i", "<C-v>", "<C-r><C-p>+")

-- Write the current buffer
map("i", "<C-s>", "<Esc><C-s>")
map("n", "<C-s>", ":silent write <cr>")

-- Close the current buffer
map("n", "<C-q>", ":quit <cr>")

-- Search the word under the cursor
map("n", "<C-f>", "*")

-- Unbind the `S` and `s` keys
map("n", "S", "<Nop>")
map("n", "s", "<Nop>")
map("v", "s", "<Nop>")

-- Change indentation using Tab
map("n", "<S-Tab>", "<<")
map("n", "<Tab>", ">>")
map("v", "<S-Tab>", "<gv")
map("v", "<Tab>", ">gv")

-- Jump through the jump list
map("n", "<leader>q", "<C-o>")
map("n", "<leader>e", "<C-i>")

-- Change and delete into the black hole register
map("n", "c", "\"_c")
map("n", "C", "\"_C")
map("n", "d", "\"_d")
map("n", "D", "\"_D")
map("x", "c", "\"_c")
map("x", "d", "\"_d")
map("x", "p", "pgvy")

-- Toggle line wrapping
map("n", "<A-w>", function()
  vim.o.wrap = not vim.o.wrap
end)

-- Close all buffers but this one
map("n", "<A-/>", ":%bd|:e#|:bd# <cr>")

-- Map <C-Leftmouse> to <LeftMouse>
map("n", "<C-LeftMouse>", "<LeftMouse>")

-- Move the lines in visual mode
-- with automatic indentation
map("v", "<A-Down>", ":m '>+1<CR>gv=gv")
map("v", "<A-Up>", ":m '<-2<CR>gv=gv")

-- Leave the cursor in the same place
-- while appending lines
map("n", "J", "mzJ`z")

local M = {}

M.map = map
M.new_bmap = new_bmap

M.on_lsp_attach = function(_, bufnr)
  local bmap = new_bmap(bufnr)

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
