local utils = require("config.utils")

if utils.known({ "shellcheck", "stylua" }) then
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  return {
    "jose-elias-alvarez/null-ls.nvim",
    dependecies = "lsp_lines.nvim",
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
          diagnostics.yamllint,
          formatting.fnlfmt,
          formatting.stylua,
          formatting.yamlfmt,
        },
      })
      -- Prepare an autocommands group
      local group = vim.api.nvim_create_augroup(name, { clear = false })
      -- Setup keybindings
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = {
          "*.bash",
          "*.md",
          "*.sh",
        },
        group = group,
        callback = function()
          local nmap = require("config.utils").nmap

          -- Setup keybindings
          nmap("ga", vim.lsp.buf.code_action)
        end,
      })
      -- Format the code before writing
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {
          "*.yaml",
          "*.yml",
        },
        group = group,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 2000 })
        end,
      })
    end,
  }
end
