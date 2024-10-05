-- Library of 20+ independent Lua modules improving
-- overall Neovim experience with minimal effort
return {
  "echasnovski/mini.nvim",
  config = function()
    -- Fast and feature-rich surround actions
    require("mini.surround").setup()
  end,
}
