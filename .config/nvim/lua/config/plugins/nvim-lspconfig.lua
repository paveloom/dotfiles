-- Quickstart configs for Nvim LSP
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "lsp_lines.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    "mfussenegger/nvim-dap",
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
      nmap("<leader>x", function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end)
      nmap("<leader>s", function()
        require("telescope.builtin").lsp_document_symbols()
      end)
    end

    -- Set up the Lua language server
    if require("config.utils").known({ "lua-language-server" }) then
      -- Set up the LSP for Lua API of Neovim
      --
      -- It's important we setup this before requiring `lspconfig`
      require("neodev").setup()
      -- Set up the LSP for any other Lua
      require("lspconfig").lua_ls.setup({
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
    end
    -- Set up the Rust language server
    if require("config.utils").known({ "rust-analyzer" }) then
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
            },
          },
        },
      })
    end
    -- Set up the TypeScript language server
    if require("config.utils").known({ "typescript-language-server" }) then
      require("lspconfig").tsserver.setup({
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
    end
    -- Set up the ESLint language server
    if require("config.utils").known({ "vscode-eslint-language-server" }) then
      require("lspconfig").eslint.setup({
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
    end
    -- Set up the Julia language server
    if require("config.utils").known({ "julia" }) then
      require("lspconfig").julials.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
    -- Set up the LanguageTool language server
    if require("config.utils").known({ "ltex-ls", "ltex-cli" }) then
      require("lspconfig").ltex.setup({
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
            enabled = {
              "javascript",
              "julia",
              "latex",
              "lua",
              "markdown",
              "rust",
              "typescript",
            },
            additionalRules = { enablePickyRules = true },
          },
        },
      })
    end
    -- Set up the LaTeX language server
    if require("config.utils").known({ "texlab", "tectonic" }) then
      require("lspconfig").texlab.setup({
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
    end
    -- Set up the Zig language server
    if require("config.utils").known({ "zig", "zls" }) then
      local lspconfig = require("lspconfig")
      lspconfig.zls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Attach the server
          on_attach(client, bufnr)
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
    end
    -- Set up the XML language server
    require("lspconfig").lemminx.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        xml = {
          format = {
            enforceQuoteStyle = "preferred",
            joinContentLines = true,
            splitAttributes = true,
          },
          preferences = {
            quoteStyle = "double",
          },
        },
      },
    })
    -- Set up the Dockerfile language server
    require("lspconfig").dockerls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- Set up the Nix language server
    if require("config.utils").known({
      "alejandra",
      "nil",
      "nixpkgs-fmt",
    }) then
      require("lspconfig").nil_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
    -- Format the code before writing
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.jl",
        "*.lua",
        "*.rs",
        "*.svg",
        "*.tex",
        "*.xml",
        "*.xsd",
        "*.nix",
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
