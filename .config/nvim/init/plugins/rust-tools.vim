lua <<EOF
require('rust-tools').setup {
  tools = {
    inlay_hints = {
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "-> ",
      highlight = "Comment",
    },

    hover_actions = {
      border = "solid",
      auto_focus = true,
    },
  },
  server = {
    standalone = false,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          overrideCommand = { "cargo", "lint" },
        },
        files = {
          excludeDirs = { ".flatpak-builder" }
        },
        procMacro = {
            enable = true,
        },
      },
    }
  },
}
EOF
