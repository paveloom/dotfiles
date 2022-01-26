lua <<EOF
require('gitsigns').setup {
  signs = {
    add = {hl = 'GitSignsAdd', text = '+', numhl='', linehl=''},
    change = {hl = 'GitSignsChange', text = '*', numhl='', linehl='' },
    delete = {hl = 'GitSignsDelete', text = '-', numhl='', linehl='' },
    topdelete = {hl = 'GitSignsDelete', text = '-', numhl='', linehl='' },
    changedelete = {hl = 'GitSignsDelete', text = '-', numhl='', linehl='' },
  },
}
EOF
