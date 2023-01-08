return {
  {
    -- Portable package manager for Neovim
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      -- Setup the plugin
      require("mason").setup({
        ui = {
          border = "single",
        },
      })
    end,
    init = function()
      local nmap = require("config.utils").nmap

      -- Setup keybindings
      nmap("<leader>m", function()
        require("mason.ui").open()
      end)
    end,
  },
  {
    -- Install and upgrade third party tools automatically
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    config = function()
      -- Setup the plugin
      require("mason-tool-installer").setup({
        auto_update = true,
        ensure_installed = {
          "dockerfile-language-server",
          "eslint-lsp",
          "julia-lsp",
          "lemminx",
          "ltex-ls",
          "lua-language-server",
          "rust-analyzer",
          "shellcheck",
          "stylua",
          "tectonic",
          "texlab",
          "typescript-language-server",
          "yamlfmt",
          "yamllint",
        },
      })
    end,
  },
}
