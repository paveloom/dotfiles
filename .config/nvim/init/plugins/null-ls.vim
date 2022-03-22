lua <<EOF
local builtins = require("null-ls").builtins
local code_actions = builtins.code_actions
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting
require("null-ls").setup({
  sources = {
    diagnostics.shellcheck,
    code_actions.shellcheck,
    code_actions.gitsigns,
    formatting.prettier,
  },
})
EOF
