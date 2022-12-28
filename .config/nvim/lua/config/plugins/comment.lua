-- Smart and powerful comment plugin for Neovim
return {
  "numToStr/Comment.nvim",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      mappings = {
        basic = false,
        extra = false,
      },
      -- A hook to trigger the `commentstring` updating logic
      pre_hook = function(ctx)
        local utils = require("Comment.utils")
        -- Determine whether to use linewise or blockwise commentstring
        local type = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline"
        -- Determine the location where to calculate commentstring from
        local location = nil
        if ctx.ctype == utils.ctype.blockwise then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end
        -- Calculate the `commentstring`
        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = type,
          location = location,
        })
      end,
    })
  end,
  init = function()
    local utils = require("config.utils")

    -- Setup keybindings
    utils.nmap("gcc", function()
      require("Comment.api").toggle.linewise.current()
    end)
    utils.xmap("gc", function()
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end)
  end,
}
