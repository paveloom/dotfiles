-- Standalone UI for `nvim-lsp` progress
require("packer").use({
  "j-hui/fidget.nvim",
  after = "lush.nvim",
  config = function()
    require("fidget").setup()
  end,
})
