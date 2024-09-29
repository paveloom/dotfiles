local utils = require("config.utils")

-- A pretty diagnostics, references, telescope results, quickfix and
-- location list to help you solve all the trouble your code is causing
return {
  "folke/trouble.nvim",
  lazy = true,
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    -- Set up the plugin
    require("trouble").setup({
      action_keys = {
        close = { "q", "<esc>" },
        cancel = {},
      },
    })
  end,
  init = function()
    utils.map("n", "<leader>t", function()
      require("trouble").toggle()
    end)
    utils.map("n", "ge", function()
      require("trouble").toggle("diagnostics")
    end)
    utils.map("n", "gi", function()
      require("trouble").toggle("lsp_implementations")
    end)
    utils.map("n", "gr", function()
      require("trouble").toggle("lsp_references")
    end)
    utils.map("n", "gt", function()
      require("trouble").toggle("lsp_type_definitions")
    end)
  end,
}
