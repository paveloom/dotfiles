local mappings = require("config.mappings")

-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "direnv/direnv.vim",
    "lsp_lines.nvim",
  },
  config = function()
    local name = "null-ls"
    local null_ls = require(name)
    local builtins = null_ls.builtins
    local completion = builtins.completion
    local diagnostics = builtins.diagnostics
    local formatting = builtins.formatting

    local function direnv_loaded()
      return vim.b.direnv_loaded ~= nil
    end

    null_ls.setup({
      on_attach = mappings.on_lsp_attach,
      sources = {
        completion.spell.with({
          runtime_condition = direnv_loaded,
        }),
        diagnostics.fish.with({
          runtime_condition = direnv_loaded,
        }),
        diagnostics.yamllint.with({
          runtime_condition = direnv_loaded,
        }),
        formatting.fnlfmt.with({
          runtime_condition = direnv_loaded,
        }),
        formatting.stylua.with({
          runtime_condition = direnv_loaded,
        }),
        formatting.xmllint.with({
          runtime_condition = direnv_loaded,
        }),
        formatting.yamlfmt.with({
          runtime_condition = direnv_loaded,
        }),
      },
    })
  end,
}
