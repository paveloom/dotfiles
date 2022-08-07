-- A small Neovim plugin to remove trailing whitespace
-- and empty lines at end of file on every save
require("packer").use({
  "mcauley-penney/tidy.nvim",
  event = "BufWritePre",
  config = function()
    require("tidy").setup()
  end
})
