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
      auto_focus = false,
    },
  },
  server = {
    standalone = false,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--", "-W", "clippy::cargo", "-W", "clippy::pedantic" },
        },
        procMacro = {
            enable = true
        },
      },
    }
  },
}
EOF
