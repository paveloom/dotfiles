-- A Neovim plugin that jump to previous and next buffer of the jumplist
return {
  "kwkarlwang/bufjump.nvim",
  keys = {
    "<leader>a",
    "<leader>d",
  },
  config = function()
    -- Set up the plugin
    require("bufjump").setup({
      backward_key = "<leader>a",
      forward_key = "<leader>d",
      on_success = function()
        vim.cmd([[execute "normal! g`\"zz"]])
      end,
    })
  end,
}
