-- Dumb automatic fast indentation detection for Neovim written in Lua
return {
  "Darazaki/indent-o-matic",
  config = function()
    require("indent-o-matic").setup({
      -- Only detect 2 spaces indentation for Lua files
      filetype_lua = {
        standard_widths = { 2 },
      },
    })
  end,
}
