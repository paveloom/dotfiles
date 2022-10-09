-- Find the enemy and replace them with dark power
require("packer").use({
  "nvim-pack/nvim-spectre",
  requires = { "nvim-lua/plenary.nvim" },
  after = "lush.nvim",
  config = function()
    local name = "spectre"
    local spectre = require(name)
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, {
        noremap = true,
        silent = true,
      })
    end

    -- Setup the plugin
    spectre.setup({
      live_update = true,
      is_insert_mode = true,
    })
    -- Setup keybindings
    nmap("<leader>r", spectre.open)
  end,
})
