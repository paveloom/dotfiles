-- A plugin for setting Neovim LSP with JSON or YAML files
return {
  "paveloom/nlsp-settings.nvim",
  dependencies = {
    "folke/noice.nvim",
  },
  config = function()
    require("nlspsettings").setup({
      nvim_notify = {
        enable = true,
      },
    })
  end,
}
