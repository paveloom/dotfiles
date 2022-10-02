-- A minimal implementation of `vim-rooter` in Lua
require("packer").use({
  "notjedi/nvim-rooter.lua",
  after = "lush.nvim",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", "=nvim" },
      exclude_filetypes = { "toggleterm" },
    })
  end,
})
