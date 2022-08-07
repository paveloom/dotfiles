-- Git integration for buffers
require("packer").use({
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    -- Setup the plugin
    gitsigns.setup {
      signs = {
        add = { hl = "GitSignsAdd", text = "+", numhl = "", linehl = "" },
        change = { hl = "GitSignsChange", text = "*", numhl = "", linehl = "" },
        delete = { hl = "GitSignsDelete", text = "-", numhl = "", linehl = "" },
        topdelete = { hl = "GitSignsDelete", text = "-", numhl = "", linehl = "" },
        changedelete = { hl = "GitSignsDelete", text = "-", numhl = "", linehl = "" },
      },
    }
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, { silent = true })
    end

    -- Setup keybindings
    nmap("gD", gitsigns.diffthis)
    nmap("gk", gitsigns.prev_hunk)
    nmap("gl", gitsigns.next_hunk)
  end,
})
