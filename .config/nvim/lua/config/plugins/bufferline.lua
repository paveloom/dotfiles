-- A snazzy bufferline for Neovim
return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    -- Setup the plugin
    require("bufferline").setup({
      options = {
        mode = "tabs",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = { "", "" },
        always_show_bufferline = false,
      },
    })
  end,
  init = function()
    local nmap = require("config.utils").nmap

    -- Setup keybindings
    nmap("<leader>.", "<cmd>:tabnew<cr>")
    nmap("<leader>k", function()
      require("bufferline").cycle(-1)
    end)
    nmap("<leader>;", function()
      require("bufferline").cycle(1)
    end)
    nmap("<leader>,", "<cmd>:-tabmove<cr>")
    nmap("<leader>/", "<cmd>:+tabmove<cr>")
  end,
}
