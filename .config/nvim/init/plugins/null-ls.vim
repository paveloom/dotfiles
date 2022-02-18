lua <<EOF
local builtins = require("null-ls").builtins
local diagnostics = builtins.diagnostics
local code_actions = builtins.code_actions
require("null-ls").setup({
  sources = {
    diagnostics.shellcheck,
    code_actions.shellcheck,
  },
})
EOF
