-- Git integration for buffers
require("packer").use({
  "lewis6991/gitsigns.nvim",
  after = "lush.nvim",
  config = function()
    -- Setup the plugin
    require("gitsigns").setup({
      signcolumn = false,
    })
  end,
})
