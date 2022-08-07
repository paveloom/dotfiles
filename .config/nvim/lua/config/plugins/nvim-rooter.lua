-- A minimal implementation of `vim-rooter` in Lua
require("packer").use({
  "notjedi/nvim-rooter.lua",
  event = "BufEnter",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", "=nvim" },
    })
  end,
})
