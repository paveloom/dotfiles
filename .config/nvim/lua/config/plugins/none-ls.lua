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

    null_ls.setup({
      on_attach = mappings.on_lsp_attach,
      sources = {
        completion.spell,
        diagnostics.fish,
        diagnostics.yamllint,
        formatting.stylua,
        formatting.xmllint,
        formatting.yamlfmt,
      },
    })
  end,
}
