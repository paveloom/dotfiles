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
    -- Rainbow delimiters for Neovim with Tree-sitter
    "HiPhish/rainbow-delimiters.nvim",
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
