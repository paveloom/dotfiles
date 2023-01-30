-- Git integration for buffers
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- Set up the plugin
    require("gitsigns").setup()
  end,
}
