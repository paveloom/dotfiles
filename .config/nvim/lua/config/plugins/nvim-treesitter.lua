return {
  {
    -- Neovim Treesitter configurations and abstraction layer
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Set up the plugin
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "markdown_inline",
          "regex",
          "vim",
        },
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
      -- Use Tree-sitter for folding
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    -- Neovim Treesitter plugin for setting the `commentstring`
    -- based on the cursor location in a file
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
  },
  {
    -- Rainbow parentheses for Neovim using Treesitter
    "p00f/nvim-ts-rainbow",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    -- Autopairs for Neovim written in Lua
    "windwp/nvim-autopairs",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
    config = function()
      -- Set up the plugin
      require("nvim-autopairs").setup({
        check_ts = true,
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", "\"", "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end,
  },
}
