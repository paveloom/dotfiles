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
          command = "clippy",
          extraArgs = {
            "--",
            "-D",
            "clippy::cargo",
            "-D",
            "clippy::complexity",
            "-D",
            "clippy::correctness",
            "-D",
            "clippy::pedantic",
            "-D",
            "clippy::perf",
            "-D",
            "clippy::restriction",
            "-D",
            "clippy::style",
            "-D",
            "clippy::suspicious",
          },
        },
        procMacro = {
            enable = true
        },
      },
    }
  },
}
EOF
