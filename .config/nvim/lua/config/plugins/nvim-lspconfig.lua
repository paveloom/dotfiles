-- Quickstart configs for Nvim LSP
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "direnv/direnv.vim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/null-ls.nvim",
    "lsp_lines.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    "mfussenegger/nvim-dap",
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }
    -- Prepare an autocommands group
    local group = vim.api.nvim_create_augroup("lspconfig", { clear = false })
    -- Set up the LSP server
    local function on_attach(_, bufnr)
      -- Map a keybinding in the normal mode
      local function nmap(k, e)
        vim.keymap.set("n", k, e, {
          noremap = true,
          silent = true,
          buffer = bufnr,
        })
      end

      -- Set up keybindings
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
        require("telescope.builtin").lsp_workspace_symbols()
      end)
    end

    -- Set up the LSP for Lua API of Neovim
    --
    -- It's important we setup this before requiring `lspconfig`
    require("neodev").setup({
      autostart = false,
      capabilities = capabilities,
    })

    -- Set up the Lua language server
    require("lspconfig").lua_ls.setup({
      autostart = false,
      single_file_support = false,
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Disable the formatting since `stylua`
        -- from `null-ls` handles that
        client.server_capabilities.document_formatting = false
        -- Attach the server
        on_attach(client, bufnr)
        -- Enable the inlay hints
        require("lsp-inlayhints").on_attach(client, bufnr, false)
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
        autostart = false,
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Attach the server
          on_attach(client, bufnr)
          -- Enable the inlay hints
          require("lsp-inlayhints").on_attach(client, bufnr, false)
        end,
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
    require("lspconfig").tsserver.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Attach the server
        on_attach(client, bufnr)
        -- Enable the inlay hints
        require("lsp-inlayhints").on_attach(client, bufnr, false)
      end,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })
    -- Set up JSON language server
    require("lspconfig").jsonls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Set up the ESLint language server
    require("lspconfig").eslint.setup({
      autostart = false,
      capabilities = capabilities,
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
    require("lspconfig").julials.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Set up the LanguageTool language server
    require("lspconfig").ltex.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
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
    require("lspconfig").texlab.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
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
    local lspconfig = require("lspconfig")
    lspconfig.zls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Attach the server
        on_attach(client, bufnr)
        -- Don't parse errors on format
        vim.g.zig_fmt_parse_errors = 0
        -- Enable the inlay hints
        require("lsp-inlayhints").on_attach(client, bufnr, false)
      end,
      root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
      settings = {
        zls = {
          enable_inlay_hints = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    })
    -- Set up the Dockerfile language server
    require("lspconfig").dockerls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Set up the Nix language server
    require("lspconfig").nil_ls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Set up the C language server
    require("lspconfig").clangd.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Attach the server
        on_attach(client, bufnr)
        -- Enable the inlay hints
        require("lsp-inlayhints").on_attach(client, bufnr, false)
      end,
    })
    -- Set up the Blueprint language server
    require("lspconfig").blueprint_ls.setup({
      autostart = false,
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Format the code before writing
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.c",
        "*.cjs",
        "*.h",
        "*.jl",
        "*.json",
        "*.lua",
        "*.nix",
        "*.rs",
        "*.svg",
        "*.tex",
        "*.xml",
        "*.xsd",
        "*.xsl",
        "*.xslt",
        "*.zig",
      },
      group = group,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end,
    })
  end,
}
