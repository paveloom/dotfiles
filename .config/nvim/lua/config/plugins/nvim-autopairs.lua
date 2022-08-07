-- Autopairs for Neovim written in Lua
require("packer").use({
  "windwp/nvim-autopairs",
  requires = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter",
  },
  after = "nvim-treesitter",
  config = function()
    -- Setup the plugin
    require("nvim-treesitter.configs").setup({
      autopairs = {
        enable = true,
      },
    })
    require("nvim-autopairs").setup({
      check_ts = true,
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end
})
