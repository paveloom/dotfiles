lua <<EOF
require('rust-tools').setup {
  tools = {
    inlay_hints = {
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "-> ",
      highlight = "Comment",
    },

    hover_actions = {
      border = "none",
      auto_focus = true,
    },
  },

  server = {
    standalone = false,
    ["rust-analyzer"] = {
      checkOnSave = {
          command = "clippy"
      },
    }
  },
}
EOF
