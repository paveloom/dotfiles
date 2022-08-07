require("packer").use({
  "feline-nvim/feline.nvim",
  after = "lush.nvim",
  config = function()
    local feline = require("feline")

    local vi_mode = require("feline.providers.vi_mode")

    local theme = require("lucid")
    local s = theme.spec
    local c = theme.colors
    -- Don't show the mode the default way
    vim.o.showmode = false
    -- Setup the plugin
    local vi_mode_colors = {
      NORMAL = c.rock_medium.hex,
      OP = c.rock_medium.hex,
      INSERT = c.turquoise.hex,
      VISUAL = c.purple.hex,
      LINES = c.powder.hex,
      BLOCK = c.powder.hex,
      REPLACE = c.fluoric.hex,
      ["V-REPLACE"] = c.cyan.hex,
      ENTER = c.sap.hex,
      MORE = c.sap.hex,
      SELECT = c.sky.hex,
      COMMAND = c.sap.hex,
      SHELL = c.sap.hex,
      TERM = c.sap.hex,
      NONE = c.rock_medium.hex,
    }

    local components = {
      active = {},
      inactive = {},
    }

    components.active[1] = {
      {
        provider = {
          name = "file_info",
          opts = {
            type = "relative",
          },
        },
        hl = "FelineFileInfo",
        left_sep = " ",
      },
      {
        provider = "vi_mode",
        hl = function()
          return {
            name = vi_mode.get_mode_highlight_name(),
            fg = vi_mode.get_mode_color(),
            style = "bold",
          }
        end,
        left_sep = " ",
        icon = "",
      },
      {
        provider = "diagnostic_errors",
        hl = "FelineDiagnosticErrors",
      },
      {
        provider = "diagnostic_warnings",
        hl = "FelineDiagnosticWarnings",
      },
      {
        provider = "diagnostic_hints",
        hl = "FelineDiagnosticHints",
      },
      {
        provider = "diagnostic_info",
        hl = "FelineDiagnosticInfo",
      },
    }

    components.active[2] = {
      {
        provider = "git_branch",
        hl = { style = "bold" },
      },
      {
        provider = "git_diff_added",
        hl = "FelineGitDiffAdded",
      },
      {
        provider = "git_diff_changed",
        hl = "FelineGitDiffChanged",
      },
      {
        provider = "git_diff_removed",
        hl = "FelineGitDiffRemoved",
      },
      {
        provider = "position",
        left_sep = " ",
      },
      {
        provider = "line_percentage",
        hl = {
          style = "bold",
        },
        left_sep = " ",
        right_sep = " ",
      },
    }

    components.inactive[1] = {
      {
        provider = {
          name = "file_info",
          opts = {
            type = "relative",
          },
        },
        hl = "FelineFileInfo",
        left_sep = " ",
        right_sep = " ",
      },
    }

    feline.setup {
      theme = { bg = s.Normal.bg.hex, fg = s.Normal.fg.hex },
      default_bg = "bg",
      default_fg = "fg",
      vi_mode_colors = vi_mode_colors,
      components = components,
      disable = {
        filetypes = {
          "^neo%-tree$",
          "^help$",
        }
      },
    }
  end,
})
