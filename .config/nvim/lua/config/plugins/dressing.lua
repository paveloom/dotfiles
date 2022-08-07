-- Neovim plugin to improve the default `vim.ui` interfaces
require("packer").use({
  "stevearc/dressing.nvim",
  requires = { "nvim-telescope/telescope.nvim" },
  after = "telescope.nvim",
  config = function()
    require("dressing").setup({
      select = {
        telescope = require("telescope.themes").get_cursor(),
      }
    })
  end,
})
