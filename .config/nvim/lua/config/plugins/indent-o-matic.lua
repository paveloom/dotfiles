-- Dumb automatic fast indentation detection for Neovim written in Lua
require("packer").use({
  "Darazaki/indent-o-matic",
  after = "lush.nvim",
  config = function()
    require("indent-o-matic").setup({
      -- Only detect 2 spaces indentation for Lua files
      filetype_lua = {
        standard_widths = { 2 },
      },
    })
  end,
})
