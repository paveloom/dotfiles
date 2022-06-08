lua <<EOF
local null_ls = require('null-ls')
local builtins = null_ls.builtins
local code_actions = builtins.code_actions
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting
null_ls.setup {
  sources = {
    code_actions.gitsigns,
    code_actions.shellcheck,
    diagnostics.shellcheck,
    formatting.prettier,
  },
}
EOF
