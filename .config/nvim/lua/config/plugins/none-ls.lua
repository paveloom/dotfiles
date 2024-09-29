local mappings = require("config.mappings")

-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "direnv/direnv.vim",
    "lsp_lines.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local builtins = null_ls.builtins
    local completion = builtins.completion
    local diagnostics = builtins.diagnostics
    local formatting = builtins.formatting

    local function executable_exists(params)
      local command = params:get_source().generator.opts.command
      if command == nil then
        return false
      end
      return vim.fn.executable(command) ~= 0
    end

    local function get_sources()
      local _sources = {
        completion.spell,
        diagnostics.fish,
        diagnostics.hadolint,
        diagnostics.yamllint,
        formatting.stylua,
        formatting.xmllint,
        formatting.yamlfmt,
      }

      local sources = {}

      for _, source in ipairs(_sources) do
        table.insert(
          sources,
          source.with({
            runtime_condition = executable_exists,
          })
        )
      end

      return sources
    end

    null_ls.setup({
      on_attach = mappings.on_lsp_attach,
      sources = get_sources(),
    })
  end,
}
