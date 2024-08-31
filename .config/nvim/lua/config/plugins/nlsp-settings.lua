-- A plugin for setting Neovim LSP with JSON or YAML files
return {
  "paveloom/nlsp-settings.nvim",
  config = function()
    require("nlspsettings").setup({})
  end,
}
