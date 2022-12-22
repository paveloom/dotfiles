-- A small Neovim plugin to remove trailing whitespace
-- and empty lines at end of file on every save
return {
  "mcauley-penney/tidy.nvim",
  config = function()
    require("tidy").setup()
  end,
}
