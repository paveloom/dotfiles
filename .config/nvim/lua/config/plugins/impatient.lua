-- Improve startup time for Neovim
require("packer").use({
  "lewis6991/impatient.nvim",
  config = function()
    require("impatient").enable_profile()
  end,
})
