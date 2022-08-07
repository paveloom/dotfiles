-- A Neovim plugin that helps managing `crates.io` dependencies
require("packer").use({
  "Saecki/crates.nvim",
  requires = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  after = "nvim-cmp",
  config = function()
    local name = "crates"
    local cmp = require("cmp")
    -- Setup the plugin
    require(name).setup()
    -- Add to the completion sources
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup(name, { clear = true }),
      pattern = "Cargo.toml",
      callback = function()
        cmp.setup.buffer({
          sources = {
            { name = name }
          }
        })
      end,
    })
  end,
})
