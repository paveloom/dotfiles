local utils = require("config.utils")

-- A snazzy bufferline for Neovim
return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    -- Set up the plugin
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
        ---@diagnostic disable-next-line: assign-type-mismatch
        separator_style = { "", "" },
        always_show_bufferline = false,
      },
    })
  end,
  init = function()
    utils.map("n", "<leader>.", function()
      require("bufferline")
      vim.cmd(":tabnew")
    end)
    utils.map("n", "<leader>k", function()
      require("bufferline").cycle(-1)
    end)
    utils.map("n", "<leader>;", function()
      require("bufferline").cycle(1)
    end)
    utils.map("n", "<leader>,", function()
      local tabs = vim.api.nvim_list_tabpages()
      -- If there is an available tab on the right
      if tabs[vim.api.nvim_tabpage_get_number(0)] ~= tabs[1] then
        require("bufferline")
        vim.cmd(":-tabmove")
      end
    end)
    utils.map("n", "<leader>/", function()
      local tabs = vim.api.nvim_list_tabpages()
      -- If there is an available tab on the right
      ---@diagnostic disable-next-line: param-type-mismatch
      if tabs[vim.api.nvim_tabpage_get_number(0)] ~= vim.fn.get(tabs, -1) then
        require("bufferline")
        vim.cmd(":+tabmove")
      end
    end)
  end,
}
