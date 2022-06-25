lua <<EOF
require('nvim-tree').setup {
  hijack_netrw = false,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  git = {
    ignore = false,
    timeout = 1000,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    highlight_opened_files = "3",
    root_folder_modifier = ":t",
    special_files = { "README.md", "LICENSE.md" },
    group_empty = true,
    highlight_git = true,
  },
  view = {
    mappings = {
      custom_only = true,
      list = {
        { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
        { key = "O", action = "edit_no_picker" },
        { key = ">", action = "cd" },
        { key = "<", action = "dir_up" },
        { key = "v", action = "vsplit" },
        { key = "h", action = "split" },
        { key = "<Tab>", action = "preview" },
        { key = "R", action = "refresh" },
        { key = "a", action = "create" },
        { key = "d", action = "trash" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "x", action = "cut" },
        { key = "c", action = "copy" },
        { key = "p", action = "paste" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_path" },
        { key = "gy", action = "copy_absolute_path" },
        { key = "[c", action = "prev_git_item" },
        { key = "]c", action = "next_git_item" },
        { key = "s", action = "system_open" },
        { key = "q", action = "close" },
        { key = "?", action = "toggle_help" },
      },
    },
  },
}
EOF
