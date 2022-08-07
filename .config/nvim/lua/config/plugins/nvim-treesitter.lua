-- Neovim Treesitter configurations and abstraction layer
require("packer").use({
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })
  end,
})

-- Neovim Treesitter plugin for setting the `commentstring`
-- based on the cursor location in a file
require("packer").use({
  "JoosepAlviste/nvim-ts-context-commentstring",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      }
    })
  end,
})
