-- Find the enemy and replace them with dark power
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Setup the plugin
    require("spectre").setup({
      live_update = true,
      is_insert_mode = true,
    })
  end,
  init = function()
    local nmap = require("config.utils").nmap

    -- Setup keybindings
    nmap("<leader>r", function()
      require("spectre").open()
    end)
  end,
}
