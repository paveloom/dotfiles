require("packer").use({
  "numToStr/Comment.nvim",
  requires = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  after = "nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup({
      -- A hook to trigger the `commentstring` updating logic
      pre_hook = function(ctx)
        local utils = require 'Comment.utils'

        -- Determine whether to use linewise or blockwise commentstring
        local type = ctx.ctype == utils.ctype.line and '__default' or '__multiline'

        -- Determine the location where to calculate commentstring from
        local location = nil
        if ctx.ctype == utils.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring({
            key = type,
            location = location,
        })
      end,
    })
  end,
})
