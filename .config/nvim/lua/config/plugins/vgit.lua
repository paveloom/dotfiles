-- Visual Git plugin for Neovim
require("packer").use({
  "tanvirtin/vgit.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  after = "gitsigns.nvim",
  config = function()
    -- Setup the plugin
    require("vgit").setup({
      keymaps = {
        ["n gk"] = "hunk_up",
        ["n gl"] = "hunk_down",
        ["n gD"] = "buffer_diff_preview",
      },
      settings = {
        live_gutter = {
          edge_navigation = false,
        },
        live_blame = {
          enabled = false,
        },
        authorship_code_lens = {
          enabled = false,
        },
        scene = {
          diff_preference = "split",
        },
        symbols = {
          void = " ",
        },
      },
    })
  end,
})
