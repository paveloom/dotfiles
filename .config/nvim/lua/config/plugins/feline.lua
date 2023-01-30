-- A minimal, stylish and customizable statusline for Neovim written in Lua
return {
  "feline-nvim/feline.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "rktjmp/lush.nvim",
  },
  config = function()
    local feline = require("feline")
    local vi_mode = require("feline.providers.vi_mode")
    local theme = require("lucid")
    local s = theme.spec
    local c = theme.colors
    -- Don't show the mode the default way
    vim.o.showmode = false
    -- Set up the plugin
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
    -- Prepare the components table
    local components = {
      active = {},
      inactive = {},
    }
    -- Set the active components on the left side of the bar
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
    -- Set the active components on the right side of the bar
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
        -- Show the number of selected lines or
        -- a number of selected characters
        provider = function()
          local _, start_row, start_col, _ = unpack(vim.fn.getpos("v"))
          local _, end_row, end_col, _ = unpack(vim.fn.getpos("."))
          local mode = vim.api.nvim_get_mode().mode
          if mode == "v" or mode == "V" then
            if start_row == end_row then
              return tostring(math.abs(end_col - start_col) + 1) .. "c"
            else
              return tostring(math.abs(end_row - start_row) + 1) .. "r"
            end
          else
            return ""
          end
        end,
        left_sep = " ",
      },
      {
        provider = "search_count",
        left_sep = " ",
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
    -- Set the inactive components
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
    -- Set up the plugin
    feline.setup({
      theme = { bg = s.Normal.bg.hex, fg = s.Normal.fg.hex },
      default_bg = "bg",
      default_fg = "fg",
      vi_mode_colors = vi_mode_colors,
      components = components,
      disable = {
        filetypes = {
          "^neo%-tree$",
          "^help$",
        },
      },
    })
  end,
}
