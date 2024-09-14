-- Quickstart configs for Nvim LSP
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "direnv/direnv.vim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "lsp_lines.nvim",
    "mfussenegger/nvim-dap",
    "natecraddock/workspaces.nvim",
    "nvimtools/none-ls.nvim",
    "paveloom/nlsp-settings.nvim",
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local group = vim.api.nvim_create_augroup("lspconfig", { clear = false })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    local function on_attach(_, bufnr)
      local function nmap(k, e)
        vim.keymap.set("n", k, e, {
          noremap = true,
          silent = true,
          buffer = bufnr,
        })
      end

      nmap("<C-S-s>", function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
        vim.cmd(":silent write")
      end)
      nmap("gR", vim.lsp.buf.rename)
      nmap("gS", vim.lsp.buf.document_symbol)
      nmap("ga", vim.lsp.buf.code_action)
      nmap("gd", vim.lsp.buf.definition)
      nmap("gh", vim.lsp.buf.hover)
      nmap("gs", vim.lsp.buf.signature_help)
      nmap("gw", vim.lsp.buf.workspace_symbol)
      nmap("<leader>s", function()
        require("telescope.builtin").lsp_document_symbols()
      end)
      nmap("<leader>S", function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end)
      nmap("<A-c>", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
    end

    local lsp_default_config = {
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    }
    lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_default_config)

    -- Set up the LSP for Lua API of Neovim
    --
    -- It's important we setup this before requiring `lspconfig`
    require("neodev").setup()

    -- Set up the Lua language server
    lspconfig.lua_ls.setup({
      single_file_support = false,
      on_attach = function(client, bufnr)
        -- Disable the formatting since `stylua`
        -- from `none-ls` handles that
        client.server_capabilities.document_formatting = false
        -- Attach the server
        on_attach(client, bufnr)
      end,
      settings = {
        Lua = {
          format = {
            enable = false,
          },
          hint = {
            enable = true,
            setType = true,
          },
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Set up the Rust language server
    require("rust-tools").setup({
      tools = {
        inlay_hints = {
          auto = false,
        },
        hover_actions = {
          border = "rounded",
          auto_focus = true,
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            files = {
              excludeDirs = { ".flatpak-builder" },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    })

    -- Set up the TypeScript language server
    lspconfig.ts_ls.setup({})

    -- Set up JSON language server
    lspconfig.jsonls.setup({})

    -- Set up the ESLint language server
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        -- Attach the server
        on_attach(client, bufnr)
        -- Fix all errors on write
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.cmd("EslintFixAll")
          end,
        })
      end,
    })

    -- Set up the Julia language server
    lspconfig.julials.setup({})

    -- Set up the LanguageTool language server
    lspconfig.ltex.setup({
      filetypes = {
        "bib",
        "gitcommit",
        "html",
        "javascript",
        "julia",
        "lua",
        "markdown",
        "org",
        "plaintex",
        "rnoweb",
        "rst",
        "rust",
        "tex",
        "typescript",
      },
      settings = {
        ltex = {
          additionalRules = { enablePickyRules = true },
          checkFrequency = "save",
          enabled = {
            "javascript",
            "julia",
            "latex",
            "lua",
            "markdown",
            "rust",
            "typescript",
          },
        },
      },
    })

    -- Set up the LaTeX language server
    lspconfig.texlab.setup({
      settings = {
        texlab = {
          build = {
            executable = "tectonic",
            args = { "-X", "compile", "%f" },
            onSave = true,
          },
        },
      },
    })

    -- Set up the Zig language server
    lspconfig.zls.setup({
      on_attach = function(client, bufnr)
        -- Attach the server
        on_attach(client, bufnr)
        -- Don't parse errors on format
        vim.g.zig_fmt_parse_errors = 0
      end,
      settings = {
        zls = {
          enable_inlay_hints = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    })

    -- Set up the Dockerfile language server
    lspconfig.dockerls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Set up the Nix language server
    lspconfig.nil_ls.setup({})

    -- Set up the C language server
    lspconfig.clangd.setup({})

    -- Set up the Blueprint language server
    lspconfig.blueprint_ls.setup({})

    -- Set up the Go language server
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    -- Set up the Bash language server
    lspconfig.bashls.setup({})

    -- Set up the HTML language server
    lspconfig.html.setup({})

    -- Set up the CSS language server
    lspconfig.cssls.setup({})
  end,
}
