-- A minimal implementation of `vim-rooter` in Lua
return {
  "notjedi/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", "=nvim" },
      exclude_filetypes = { "toggleterm" },
    })
  end,
}
