-- A completion plugin for Neovim coded in Lua
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      -- Check if there are words before the cursor
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- Setup completion
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            before = function(_, item)
              -- Remove extra text (i.e., signatures)
              item.menu = nil
              return item
            end,
          }),
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
          ["<PageDown>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            local snippy = require("snippy")
            if cmp.visible() then
              cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            elseif has_words_before() then
              cmp.complete({})
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            local snippy = require("snippy")
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snippy.can_jump(-1) then
              snippy.previous()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "latex_symbols" },
          { name = "nvim_lsp" },
          { name = "snippy" },
        }),
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end,
        },
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    -- An `nvim-cmp` source for buffer words
    "hrsh7th/cmp-buffer",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = { "CmdlineEnter", "InsertEnter" },
  },
  {
    -- An `nvim-cmp` source for path
    "hrsh7th/cmp-path",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = { "CmdlineEnter", "InsertEnter" },
  },
  {
    -- An `nvim-cmp` source for Vim's cmdline
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = { "CmdlineEnter", "InsertEnter" },
  },
  {
    -- `nvim-snippy` completion source for `nvim-cmp`
    "dcampos/cmp-snippy",
    dependencies = {
      "dcampos/nvim-snippy",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
  },
  {
    -- Add LaTeX symbol support for `nvim-cmp`
    "kdheepak/cmp-latex-symbols",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = { "CmdlineEnter", "InsertEnter" },
  },
  {
    -- An `nvim-cmp` source for Neovim builtin LSP client
    "hrsh7th/cmp-nvim-lsp",
    dependencies = { "hrsh7th/nvim-cmp" },
    lazy = true,
  },
}
