return {
  {
    -- Create Neovim themes with real-time feedback, export anywhere
    "rktjmp/lush.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Add the specified theme to the `package.path`
      package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/config/themes/?.lua"
      -- Load the spec
      local spec = require("lucid").spec
      -- Apply the base spec
      require("lush")(spec)
    end,
  },
  {
    -- Lua fork of `vim-web-devicons` for Neovim
    "nvim-tree/nvim-web-devicons",
    dependencies = "rktjmp/lush.nvim",
  },
}
