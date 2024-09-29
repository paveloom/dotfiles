local mappings = require("config.mappings")

-- Visual Git plugin for Neovim
return {
  "tanvirtin/vgit.nvim",
  lazy = true,
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    -- Set up the plugin
    require("vgit").setup({
      settings = {
        git = {
          fallback_cwd = "",
          fallback_args = {},
        },
        live_gutter = {
          -- Will use the `gitsigns` plugin for that
          enabled = false,
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
  init = function()
    mappings.map("n", "gD", function()
      require("vgit").buffer_diff_preview()
    end)
    mappings.map("n", "gk", function()
      require("vgit").hunk_up()
    end)
    mappings.map("n", "gl", function()
      require("vgit").hunk_down()
    end)
  end,
}
