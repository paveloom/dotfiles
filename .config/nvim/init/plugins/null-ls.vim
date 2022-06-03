lua <<EOF
local null_ls = require('null-ls')
local builtins = null_ls.builtins
local code_actions = builtins.code_actions
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting
null_ls.setup({
  sources = {
    diagnostics.shellcheck,
    code_actions.shellcheck,
    code_actions.gitsigns,
    formatting.prettier,
  },
})
EOF
