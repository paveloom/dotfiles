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
    local nmap = require("config.utils").nmap

    -- Set up keybindings
    nmap("<leader>t", function()
      require("trouble").toggle()
    end)
    nmap("ge", function()
      require("trouble").toggle("workspace_diagnostics")
    end)
    nmap("gi", function()
      require("trouble").toggle("lsp_implementations")
    end)
    nmap("gr", function()
      require("trouble").toggle("lsp_references")
    end)
    nmap("gt", function()
      require("trouble").toggle("lsp_type_definitions")
    end)
  end,
}
