local utils = require("config.utils")

if utils.known({ "glow" }) then
  -- A markdown preview directly in your Neovim
  return {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        border = "rounded",
      })
    end,
  }
else
  return {}
end
