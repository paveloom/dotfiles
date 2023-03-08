-- A Neovim plugin that helps managing `crates.io` dependencies
return {
  "Saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Set up the plugin
    require("crates").setup()
  end,
  init = function()
    local name = "crates"
    -- Add to the completion sources
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup(name, { clear = true }),
      pattern = "Cargo.toml",
      callback = function()
        require("cmp").setup.buffer({
          sources = {
            { name = name },
          },
        })
      end,
    })
  end,
}
