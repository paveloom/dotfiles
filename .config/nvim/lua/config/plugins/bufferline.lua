-- A snazzy bufferline for Neovim
require("packer").use({
  "akinsho/bufferline.nvim",
  requires = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local bufferline = require("bufferline")
    -- Setup the plugin
    bufferline.setup({
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
        ---@diagnostic disable-next-line: assign-type-mismatch
        separator_style = { "", "" },
        always_show_bufferline = false,
      },
    })
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, { silent = true })
    end

    -- Setup keybindings
    nmap("<leader>.", "<cmd>:tabnew<cr>")
    nmap("<leader>k", function()
      bufferline.cycle(-1)
    end)
    nmap("<leader>;", function()
      bufferline.cycle(1)
    end)
    nmap("<leader>,", "<cmd>:-tabmove<cr>")
    nmap("<leader>/", "<cmd>:+tabmove<cr>")
  end,
})
