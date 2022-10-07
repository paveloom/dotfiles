local packer = require("packer")

-- Portable package manager for Neovim
packer.use({
  "williamboman/mason.nvim",
  after = "lush.nvim",
  config = function()
    -- Setup the plugin
    require("mason").setup({
      ui = {
        border = "single",
      },
    })
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, {
        noremap = true,
        silent = true,
      })
    end

    -- Setup keybindings
    nmap("<leader>s", require("mason.ui").open)
  end,
})

-- Install and upgrade third party tools automatically
packer.use({
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  after = "mason.nvim",
  config = function()
    -- Setup the plugin
    require("mason-tool-installer").setup({
      auto_update = true,
      ensure_installed = {
        "eslint-lsp",
        "julia-lsp",
        "ltex-ls",
        "lua-language-server",
        "rust-analyzer",
        "shellcheck",
        "stylua",
        "texlab",
        "typescript-language-server",
      },
    })
  end,
})
