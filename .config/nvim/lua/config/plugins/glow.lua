local utils = require("config.utils")

if utils.known({ "glow" }) then
  -- A markdown preview directly in your Neovim
  require("packer").use({
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        border = "rounded",
      })
    end
  })
end
