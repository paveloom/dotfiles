-- Git integration for buffers
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- Setup the plugin
    require("gitsigns").setup()
  end,
}
