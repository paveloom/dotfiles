lua <<EOF
filetypes = { "html", "latex", "markdown", "rust", "julia" }
require('lspconfig').ltex.setup{
  filetypes = filetypes,
  settings = {
    ltex = {
      enabled = filetypes,
      additionalRules = { enablePickyRules = true },
    }
  }
}
EOF
