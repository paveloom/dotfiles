local wezterm = require("wezterm")
local act = wezterm.action

-- Change the formatting of the tabs
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  tabs = tabs
  panes = panes
  config = config
  hover = hover
  max_width = max_width
  return {
    { Attribute = { Italic = true } },
    { Background = { Color = "#0e0b13" } },
    { Foreground = { Color = tab.is_active and "#e3dfec" or "#847e91" } },
    { Text = " " .. tab.active_pane.title .. " " },
  }
end)

return {
  check_for_updates = false,
  font_size = 14.0,
  font = wezterm.font({
    family = "JetBrains Mono",
    -- Disable ligatures
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  }),
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_max_width = 40,
  force_reverse_video_cursor = true,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  scrollback_lines = 5000,
  -- Console's color palette: https://gitlab.gnome.org/GNOME/console/-/blob/8ae8ca86bce673295726d706f25fd515744771c1/src/kgx-terminal.c#L140
  colors = {
    -- The default text color
    foreground = "#ffffff",
    -- The default background color
    background = "#0e0b13",
    -- The foreground color of selected text
    selection_fg = "#0e0b13",
    -- The background color of selected text
    selection_bg = "#fde9a0",
    -- The color of the split lines between panes
    split = "#444444",
    -- ANSI color palette: standard colors
    ansi = {
      "#241f31", -- Black
      "#c01c28", -- Red
      "#2ec27e", -- Green
      "#f5c211", -- Yellow
      "#1e78e4", -- Blue
      "#9841bb", -- Magenta
      "#0ab9dc", -- Cyan
      "#c0bfbc", -- White
    },
    -- ANSI color palette: high-intensity colors
    brights = {
      "#5e5c64", -- Bright Black
      "#ed333b", -- Bright Red
      "#57e389", -- Bright Green
      "#f8e45c", -- Bright Yellow
      "#51a1ff", -- Bright Blue
      "#c061cb", -- Bright Magenta
      "#4fd2fd", -- Bright Cyan
      "#f6f5f4", -- Bright White
    },
    tab_bar = {
      background = "#0e0b13",
    },
  },
  tab_bar_style = {
    new_tab = wezterm.format({
      { Text = "" },
    }),
    new_tab_hover = wezterm.format({
      { Text = "" },
    }),
  },
  keys = {
    -- Turn off default toggle full screen keybinding
    { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
    -- Toggle full screen
    { key = "f", mods = "ALT", action = act.ToggleFullScreen },
    -- Move the current tab to the left
    { key = "LeftArrow", mods = "ALT", action = act.MoveTabRelative(-1) },
    -- Move the current tab to the right
    { key = "RightArrow", mods = "ALT", action = act.MoveTabRelative(1) },
    -- Create a vertical split
    { key = "'", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- Create a horizontal split
    { key = "\"", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- Adjust the pane size left
    { key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
    -- Adjust the pane size right
    { key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
    -- Adjust the pane size up
    { key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
    -- Adjust the pane size down
    { key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
    -- Scroll one page up
    { key = "PageUp", mods = "CTRL", action = act.ScrollByPage(-1) },
    -- Scroll one page down
    { key = "PageDown", mods = "CTRL", action = act.ScrollByPage(1) },
  },
  mouse_bindings = {
    -- Only select on Click
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("PrimarySelection"),
    },
    -- Bind 'Up' event of CTRL-Click to open hyperlinks
    --
    -- Note that if an application captures the mouse inputs
    -- (e.g., Neovim), you should also press Shift
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.Nop,
    },
  },
}
