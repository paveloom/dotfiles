-- Keep buffer dimensions in proportion when terminal window is resized
return {
  "kwkarlwang/bufresize.nvim",
  config = function()
    require("bufresize").setup()
  end,
}
