lua <<EOF
telescope = require('telescope')
telescope.setup {
  defaults = require('telescope.themes').get_ivy {
    mappings = {
      i = {
        ["<Esc>"] = "close",
      }
    },
  },
  pickers = {
    find_files = {
      file_ignore_patterns = { "^.git/", "target/" },
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = "delete_buffer",
        }
      }
    }
  },
  extensions = {
    project = {
      hidden_files = true,
    },
    file_browser = {
      select_buffer = true,
      dir_icon = '',
      hijack_netrw = true,
    }
  }
}
telescope.load_extension('project')
telescope.load_extension('file_browser')
EOF
