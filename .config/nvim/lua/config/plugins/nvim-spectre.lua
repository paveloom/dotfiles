-- Find the enemy and replace them with dark power
return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    -- Set up the plugin
    require("spectre").setup({
      live_update = true,
      is_insert_mode = true,
    })
  end,
  init = function()
    local nmap = require("config.utils").nmap

    -- Set up keybindings
    nmap("<leader>r", function()
      require("spectre").open()
    end)
  end,
}
