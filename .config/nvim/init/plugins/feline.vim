" Don't show the mode the usual way
set noshowmode

lua <<EOF
local feline = require('feline')
local vi_mode = require('feline.providers.vi_mode')

local vi_mode_colors = {
  NORMAL = vim.g.Color13,
  OP = vim.g.Color13,
  INSERT = vim.g.Color9,
  VISUAL = vim.g.Color8,
  LINES = vim.g.Color8,
  BLOCK = vim.g.Color8,
  REPLACE = vim.g.Color2,
  ['V-REPLACE'] = vim.g.Color2,
  ENTER = vim.g.Color5,
  MORE = vim.g.Color5,
  SELECT = vim.g.Color3,
  COMMAND = vim.g.Color11,
  SHELL = vim.g.Color11,
  TERM = vim.g.Color11,
  NONE = vim.g.Color4,
}

local components = {
  active = {},
  inactive = {},
}

components.active[1] = {
  {
    provider = 'file_info',
    hl = { style = 'bold' },
    left_sep = ' ',
  },
  {
    provider = 'vi_mode',
    hl = function()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = vi_mode.get_mode_color(),
        style = 'bold',
      }
    end,
    left_sep = ' ',
    icon = '',
  },
  {
    provider = 'diagnostic_errors',
    hl = 'FelineDiagnosticErrors',
  },
  {
    provider = 'diagnostic_warnings',
    hl = 'FelineDiagnosticWarnings',
  },
  {
    provider = 'diagnostic_hints',
    hl = 'FelineDiagnosticHints',
  },
  {
    provider = 'diagnostic_info',
    hl = 'FelineDiagnosticInfo',
  },
}

components.active[2] = {
  {
    provider = 'git_branch',
    hl = { style = 'bold' },
  },
  {
    provider = 'git_diff_added',
    hl = 'FelineGitDiffAdded',
  },
  {
    provider = 'git_diff_changed',
    hl = 'FelineGitDiffChanged',
  },
  {
    provider = 'git_diff_removed',
    hl = 'FelineGitDiffRemoved',
  },
  {
    provider = 'position',
    left_sep = ' ',
  },
  {
    provider = 'line_percentage',
    hl = {
      style = 'bold',
    },
    left_sep = ' ',
    right_sep = ' ',
  },
}

components.inactive[1] = {
  {
    provider = 'file_type',
    hl = 'FelineFileType',
    left_sep = ' ',
    right_sep = ' ',
  },
}

local force_inactive = {
  filetypes = {'NvimTree'},
  buftypes = {},
  bufnames = {}
}

feline.setup {
  theme = { bg = vim.g.Color10, fg = vim.g.Color0 },
  default_bg = bg,
  default_fg = fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
}
EOF
