local mappings = require("config.mappings")

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
    mappings.map("n", "<leader>t", function()
      require("trouble").toggle()
    end)
    mappings.map("n", "ge", function()
      require("trouble").toggle("diagnostics")
    end)
    mappings.map("n", "gi", function()
      require("trouble").toggle("lsp_implementations")
    end)
    mappings.map("n", "gr", function()
      require("trouble").toggle("lsp_references")
    end)
    mappings.map("n", "gt", function()
      require("trouble").toggle("lsp_type_definitions")
    end)
  end,
}
