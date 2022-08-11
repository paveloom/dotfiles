-- Renders diagnostics using virtual lines on top of the real line of code
require("packer").use({
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  after = "lush.nvim",
  config = function()
    -- Setup the plugin
    require("lsp_lines").setup()
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, {
        noremap = true,
        silent = true,
      })
    end

    -- Switch between display modes based on the current value of `virtual_lines`
    local function configure(toggled)
      vim.diagnostic.config({
        virtual_text = toggled,
        virtual_lines = not toggled,
      })
      nmap("g,", function() vim.diagnostic.goto_prev({ float = toggled }) end)
      nmap("g.", function() vim.diagnostic.goto_next({ float = toggled }) end)
    end

    -- Set the default configuration
    configure(true)
    -- Setup the keybindings
    nmap("<A-v>", function()
      configure(vim.diagnostic.config().virtual_lines)
    end)
  end,
})
