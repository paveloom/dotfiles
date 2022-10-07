local utils = require("config.utils")

if utils.known({ "shellcheck", "stylua" }) then
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  require("packer").use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "lush.nvim",
    config = function()
      local name = "null-ls"
      local null_ls = require(name)
      local builtins = null_ls.builtins
      local code_actions = builtins.code_actions
      local completion = builtins.completion
      local diagnostics = builtins.diagnostics
      local formatting = builtins.formatting
      -- Setup the plugin
      null_ls.setup({
        sources = {
          code_actions.shellcheck,
          completion.spell,
          diagnostics.fish,
          diagnostics.shellcheck,
          formatting.stylua,
        },
      })
      -- Setup keybindings
      local group = vim.api.nvim_create_augroup(name, { clear = false })
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = {
          "*.bash",
          "*.md",
          "*.sh",
        },
        group = group,
        callback = function()
          -- Map a keybinding in the normal mode
          local function nmap(k, e)
            vim.keymap.set("n", k, e, {
              noremap = true,
              silent = true,
            })
          end

          nmap("ga", vim.lsp.buf.code_action)
        end,
      })
    end,
  })
end
