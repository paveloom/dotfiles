local mappings = require("config.mappings")

-- Renders diagnostics using virtual lines on top of the real line of code
return {
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  lazy = true,
  config = function()
    require("lsp_lines").setup()

    -- Switch between display modes based on the current value of `virtual_lines`
    local function configure(toggled)
      vim.diagnostic.config({
        virtual_text = toggled,
        virtual_lines = not toggled,
      })
      mappings.map("n", "g,", function()
        vim.diagnostic.goto_prev({ float = toggled })
      end)
      mappings.map("n", "g.", function()
        vim.diagnostic.goto_next({ float = toggled })
      end)
    end

    -- Set the default configuration
    configure(true)

    mappings.map("n", "<A-v>", function()
      configure(vim.diagnostic.config().virtual_lines)
    end)
  end,
}
