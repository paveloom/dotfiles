-- Add/change/delete surrounding delimiter pairs with ease
require("packer").use({
  "kylechui/nvim-surround",
  after = "lush.nvim",
  config = function()
    require("nvim-surround").setup()
  end,
})
