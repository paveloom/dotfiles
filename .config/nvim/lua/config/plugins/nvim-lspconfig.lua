-- Quickstart configs for Nvim LSP
require("packer").use({
  "neovim/nvim-lspconfig",
  requires = {
    "folke/trouble.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "mfussenegger/nvim-dap",
    "ray-x/lsp_signature.nvim",
    "simrat39/rust-tools.nvim",
  },
  after = {
    "cmp-nvim-lsp",
    "trouble.nvim",
  },
  config = function()
    local name = "lspconfig"
    local lspconfig = require(name)
    local trouble = require("trouble")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- Change the border
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    -- Prepare an autocommands group
    local group = vim.api.nvim_create_augroup(name, { clear = false })
    -- Setup the LSP server
    local function on_attach(_, bufnr)
      -- Map a keybinding in the normal mode
      local function nmap(k, e)
        vim.keymap.set("n", k, e, {
          noremap = true,
          silent = true,
          buffer = bufnr,
        })
      end

      -- Enhance the signature help
      local signature_config = {
        fix_pos = true,
        floating_window = false,
        floating_window_above_cur_line = true,
        hint_enable = false,
        select_signature_key = "<A-s>",
        toggle_key = "<A-x>",
      }
      require("lsp_signature").on_attach(signature_config, bufnr)
      -- Setup keybindings
      nmap("gR", vim.lsp.buf.rename)
      nmap("gS", vim.lsp.buf.document_symbol)
      nmap("ga", vim.lsp.buf.code_action)
      nmap("gd", vim.lsp.buf.definition)
      nmap("ge", function()
        trouble.toggle("workspace_diagnostics")
      end)
      nmap("gi", function()
        trouble.toggle("lsp_implementations")
      end)
      nmap("gh", vim.lsp.buf.hover)
      nmap("gr", function()
        trouble.toggle("lsp_references")
      end)
      nmap("gs", vim.lsp.buf.signature_help)
      nmap("gt", function()
        trouble.toggle("lsp_type_definitions")
      end)
      nmap("gw", vim.lsp.buf.workspace_symbol)
    end

    -- Setup Lua language server
    if require("config.utils").known({ "lua-language-server" }) then
      lspconfig.sumneko_lua.setup({
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
    -- Setup Rust language server
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
    -- Setup TypeScript language server
    if require("config.utils").known({ "typescript-language-server" }) then
      lspconfig.tsserver.setup({
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
    -- Setup ESLint language server
    if require("config.utils").known({ "vscode-eslint-language-server" }) then
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      -- Fix all errors on write
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {
          "*.tsx",
          "*.ts",
          "*.jsx",
          "*.js",
          "*.cjs",
        },
        group = group,
        callback = function()
          vim.cmd("EslintFixAll")
        end,
      })
    end
    -- Setup Julia language server
    if require("config.utils").known({ "julia" }) then
      lspconfig.julials.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
    -- Setup LanguageTool language server
    if require("config.utils").known({ "ltex-ls", "ltex-cli" }) then
      lspconfig.ltex.setup({
        settings = {
          ltex = {
            enabled = {
              "julia",
              "latex",
              "markdown",
              "rust",
            },
            additionalRules = { enablePickyRules = true },
          },
        },
      })
    end
    -- Setup LaTeX language server
    if require("config.utils").known({ "texlab", "tectonic" }) then
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
    end
    -- Setup Zig language server
    if require("config.utils").known({ "zig", "zls" }) then
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
    -- Format the code before writing
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.jl",
        "*.lua",
        "*.rs",
        "*.tex",
        "*.zig",
      },
      group = group,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end,
    })
  end,
})
