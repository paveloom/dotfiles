local utils = require("config.utils")

-- A markdown preview directly in your Neovim
return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  config = function()
    require("glow").setup({
      border = "rounded",
    })
  end,
}
