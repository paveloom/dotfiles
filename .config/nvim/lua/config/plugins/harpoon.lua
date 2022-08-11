-- A per project, auto updating and editable marks utility for fast file navigation
require("packer").use({
  "ThePrimeagen/harpoon",
  requires = { "nvim-lua/plenary.nvim" },
  after = "lush.nvim",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, { silent = true })
    end

    -- Setup keybindings
    for i = 1, 9 do
      nmap("<leader>" .. i, function() ui.nav_file(i) end)
    end
    nmap("<leader>x", mark.add_file)
    nmap("<leader>z", ui.nav_prev)
    nmap("<leader>c", ui.nav_next)
    nmap("<leader>m", ui.toggle_quick_menu)
  end,
})
