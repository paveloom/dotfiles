local packer = require("packer")

-- Neovim Treesitter configurations and abstraction layer
packer.use({
  "nvim-treesitter/nvim-treesitter",
  after = "lush.nvim",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
      },
      autopairs = {
        enable = true,
      },
    })
  end,
})

-- Neovim Treesitter plugin for setting the `commentstring`
-- based on the cursor location in a file
packer.use({
  "JoosepAlviste/nvim-ts-context-commentstring",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "nvim-treesitter",
})

-- Rainbow parentheses for Neovim using `tree-sitter`
packer.use({
  "p00f/nvim-ts-rainbow",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "nvim-treesitter",
})

-- Autopairs for Neovim written in Lua
packer.use({
  "windwp/nvim-autopairs",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "nvim-treesitter",
  config = function()
    -- Setup the plugin
    require("nvim-autopairs").setup({
      check_ts = true,
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", "\"", "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end,
})
