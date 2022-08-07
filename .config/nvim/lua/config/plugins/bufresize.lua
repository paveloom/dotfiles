-- Keep buffer dimensions in proportion when terminal window is resized
require("packer").use({
  "kwkarlwang/bufresize.nvim",
  after = "lush.nvim",
  config = function()
    require("bufresize").setup()
  end,
})
