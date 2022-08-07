-- Create Neovim themes with real-time feedback, export anywhere
require("packer").use({
  "rktjmp/lush.nvim",
  requires = { "nvim-treesitter/nvim-treesitter" },
  after = "impatient.nvim",
  config = function()
    -- Add the specified theme to the `package.path`
    package.path = package.path
        .. ";" .. vim.fn.stdpath("config")
        .. "/lua/config/themes/?.lua"
    -- Load the spec
    local spec = require("lucid").spec
    -- Apply the base spec
    require("lush")(spec)
  end
})
