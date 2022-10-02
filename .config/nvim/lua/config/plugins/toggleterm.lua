--  A Neovim Lua plugin to help easily manage multiple terminal windows
require("packer").use({
  "akinsho/toggleterm.nvim",
  after = "lush.nvim",
  config = function()
    -- Setup the plugin
    require("toggleterm").setup({
      shade_terminals = false,
    })
    -- Add a `lazygit` terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        width = vim.api.nvim_win_get_width(0) - 5,
        height = vim.api.nvim_win_get_height(0) - 5,
      },
      on_open = function(term)
        vim.keymap.set("t", "<leader>l", "<cmd>close<CR>", {
          noremap = true,
          silent = true,
          buffer = term.bufnr,
        })
      end,
    })
    -- Toggle the state of the `lazygit` terminal
    local function lazygit_toggle()
      lazygit:toggle()
    end

    -- Setup the keybindings
    vim.keymap.set("n", "<leader>l", lazygit_toggle, { noremap = true, silent = true })
  end,
})
