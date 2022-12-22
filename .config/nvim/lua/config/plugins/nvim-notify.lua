-- A fancy, configurable, notification manager for NeoVim
return {
  "rcarriga/nvim-notify",
  dependencies = { "nvim-telescope/telescope.nvim" },
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
}
