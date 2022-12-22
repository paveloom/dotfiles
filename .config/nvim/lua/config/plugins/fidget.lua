-- Standalone UI for `nvim-lsp` progress
return {
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup()
  end,
}
