-- A Neovim plugin that jump to previous and next buffer of the jumplist
require("packer").use({
  "kwkarlwang/bufjump.nvim",
  config = function()
    -- Setup the plugin
    require("bufjump").setup({
      backward = "<leader>a",
      forward = "<leader>d",
      on_success = function()
        vim.cmd([[execute "normal! g`\"zz"]])
      end,
    })
  end
})
