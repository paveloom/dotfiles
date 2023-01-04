-- Highly experimental plugin that completely replaces
-- the UI for messages, cmdline and the popupmenu
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      popupmenu = {
        backend = "cmp",
      },
      presets = {
        lsp_doc_border = true,
      },
      messages = {
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
      },
      notify = {
        view = "mini",
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
      },
    })
  end,
}
