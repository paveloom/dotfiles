-- Treesitter powered spellchecker
require("packer").use({
  "lewis6991/spellsitter.nvim",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "nvim-treesitter",
  config = function()
    require("spellsitter").setup()
  end,
})
