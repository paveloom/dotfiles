-- A fancy, configurable, notification manager for NeoVim
require("packer").use({
  "rcarriga/nvim-notify",
  requires = { "nvim-telescope/telescope.nvim" },
  after = "telescope.nvim",
  config = function()
    local notify = require("notify")
    -- Setup the plugin
    notify.setup({
      render = "minimal",
      stages = "fade",
    })
    -- Change the default notifications handler
    vim.notify = notify
  end,
})
