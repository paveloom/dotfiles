local packer = require("packer")

-- A completion plugin for Neovim coded in Lua
packer.use({
  "hrsh7th/nvim-cmp",
  requires = {
    "dcampos/nvim-snippy",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local snippy = require("snippy")
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
          end
        }),
      },
      view = {
        entries = { name = "custom", selection_order = "near_cursor" }
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-w>"] = cmp.mapping.scroll_docs(-4),
        ["<C-s>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
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
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { "i", "s" })
      }),
      sources = cmp.config.sources({
        { name = "buffer" },
        { name = "latex_symbols" },
        { name = "nvim_lsp" },
        { name = "snippy" }
      }),
      snippet = {
        expand = function(args)
          require("snippy").expand_snippet(args.body)
        end,
      }
    })
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "buffer" }
      })
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" }
      })
    })
  end,
})

-- An `nvim-cmp` source for buffer words
packer.use({
  "hrsh7th/cmp-buffer",
  requires = { "hrsh7th/nvim-cmp" },
})

-- An `nvim-cmp` source for path
packer.use({
  "hrsh7th/cmp-path",
  requires = { "hrsh7th/nvim-cmp" },
})

-- An `nvim-cmp` source for Vim's cmdline
packer.use({
  "hrsh7th/cmp-cmdline",
  requires = { "hrsh7th/nvim-cmp" },
})

-- `nvim-snippy` completion source for `nvim-cmp`
packer.use({
  "dcampos/cmp-snippy",
  requires = { "hrsh7th/nvim-cmp" },
})

-- Add LaTeX symbol support for `nvim-cmp`
packer.use({
  "kdheepak/cmp-latex-symbols",
  requires = { "hrsh7th/nvim-cmp" },
})

-- An `nvim-cmp` source for Neovim builtin LSP client
packer.use({
  "hrsh7th/cmp-nvim-lsp",
  requires = { "hrsh7th/nvim-cmp" },
})
