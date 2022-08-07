-- Dumb automatic fast indentation detection for Neovim written in Lua
require("packer").use({
  "Darazaki/indent-o-matic",
  event = "BufEnter",
})
