-- A pretty diagnostics, references, telescope results, quickfix and
-- location list to help you solve all the trouble your code is causing
require("packer").use({
  "folke/trouble.nvim",
  requires = { "kyazdani42/nvim-web-devicons" },
  after = "lush.nvim",
  config = function()
    local trouble = require("trouble")
    -- Setup the plugin
    trouble.setup({
      action_keys = {
        close = { "q", "<esc>" },
        cancel = {},
      },
    })
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, {
        noremap = true,
        silent = true,
      })
    end

    -- Setup keybindings
    nmap("<leader>t", trouble.toggle)
  end,
})
