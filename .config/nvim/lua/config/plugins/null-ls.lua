local utils = require("config.utils")

if utils.known({ "shellcheck" }) then
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  require("packer").use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "lush.nvim",
    config = function()
      local null_ls = require("null-ls")
      local builtins = null_ls.builtins
      local code_actions = builtins.code_actions
      local completion = builtins.completion
      local diagnostics = builtins.diagnostics
      null_ls.setup {
        sources = {
          code_actions.gitsigns,
          code_actions.shellcheck,
          completion.spell,
          diagnostics.fish,
          diagnostics.shellcheck,
        },
      }
    end,
  })
end
