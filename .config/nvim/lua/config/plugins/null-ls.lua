-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "direnv/direnv.vim",
    "lsp_lines.nvim",
  },
  config = function()
    local name = "null-ls"
    local null_ls = require(name)
    local builtins = null_ls.builtins
    local code_actions = builtins.code_actions
    local completion = builtins.completion
    local diagnostics = builtins.diagnostics
    local formatting = builtins.formatting

    local function direnv_loaded()
      return vim.b.direnv_loaded ~= nil
    end
    -- Set up the plugin
    null_ls.setup({
      sources = {
        code_actions.shellcheck.with({
          runtime_condition = direnv_loaded,
        }),
        completion.spell.with({
          runtime_condition = direnv_loaded,
        }),
        diagnostics.clang_check.with({
          runtime_condition = direnv_loaded,
        }),
        diagnostics.cpplint.with({
          extra_args = { "--verbose=0" },
          extra_filetypes = { "h" },
          runtime_condition = direnv_loaded,
        }),
        diagnostics.fish.with({
          runtime_condition = direnv_loaded,
        }),
        diagnostics.shellcheck.with({
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
    -- Prepare an autocommands group
    local group = vim.api.nvim_create_augroup(name, { clear = false })
    -- Treat `*.yuck` files as Fennel files
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = {
        "*.yuck",
      },
      group = group,
      callback = function()
        vim.bo.filetype = "fennel"
      end,
    })
    -- Set up keybindings
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = {
        "*.bash",
        "*.md",
        "*.sh",
      },
      group = group,
      callback = function()
        local nmap = require("config.utils").nmap

        -- Set up keybindings
        nmap("ga", vim.lsp.buf.code_action)
      end,
    })
    -- Format the code before writing
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.xml",
        "*.xml.in",
        "*.xml.in.in",
        "*.yaml",
        "*.yml",
        ".clang-format",
      },
      group = group,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end,
    })
  end,
}
