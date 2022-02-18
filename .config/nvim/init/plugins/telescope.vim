lua <<EOF
require('telescope').setup {
  defaults = require('telescope.themes').get_ivy {
    mappings = {
      i = {
        ["<Esc>"] = "close",
      }
    },
  },
  pickers = {
    find_files = {
      file_ignore_patterns = { "^.git/" },
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = "delete_buffer",
        }
      }
    }
  }
}
EOF
