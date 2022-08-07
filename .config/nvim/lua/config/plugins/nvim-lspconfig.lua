-- Quickstart configs for Nvim LSP
require("packer").use({
  "neovim/nvim-lspconfig",
  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "simrat39/rust-tools.nvim",
    "mfussenegger/nvim-dap",
    {
      -- A pretty diagnostics, references, telescope results, quickfix and
      -- location list to help you solve all the trouble your code is causing
      "folke/trouble.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        -- Setup the plugin
        require("trouble").setup({
          action_keys = {
            close = { "q", "<esc>" },
            cancel = {},
          }
        })
      end,
    }
  },
  ft = {
    "julia",
    "latex",
    "lua",
    "markdown",
    "rust",
  },
  after = "cmp-nvim-lsp",
  config = function()
    local name = "lspconfig"
    local lspconfig = require(name)
    local trouble = require("trouble")
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Change the border
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )
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

      -- Setup keybindings
      nmap("<leader>t", function() trouble.toggle() end)
      nmap("g,", function() vim.diagnostic.goto_prev() end)
      nmap("g.", function() vim.diagnostic.goto_next() end)
      nmap("gR", function() vim.lsp.buf.rename() end)
      nmap("gS", function() vim.lsp.buf.document_symbol() end)
      nmap("ga", function() vim.lsp.buf.code_action() end)
      nmap("gd", function() vim.lsp.buf.definition() end)
      nmap("ge", function() trouble.toggle("workspace_diagnostics") end)
      nmap("gi", function() trouble.toggle("lsp_implementations") end)
      nmap("gh", function() vim.lsp.buf.hover() end)
      nmap("gr", function() trouble.toggle("lsp_references") end)
      nmap("gs", function() vim.lsp.buf.signature_help() end)
      nmap("gt", function() trouble.toggle("lsp_type_definitions") end)
      nmap("gw", function() vim.lsp.buf.workspace_symbol() end)
    end

    -- Setup Lua language server
    if require("config.utils").known({ "lua-language-server" }) then
      lspconfig.sumneko_lua.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            format = {
              defaultConfig = {
                quote_style = "double",
              }
            }
          },
        },
      })
    end

    -- Setup Rust language server
    if require("config.utils").known({ "rust-analyzer" }) then
      require("rust-tools").setup({
        tools = {
          inlay_hints = {
            show_variable_name = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "-> ",
          },
          hover_actions = {
            border = "rounded",
            auto_focus = true,
          },
        },
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                overrideCommand = { "cargo", "lint" },
              },
              files = {
                excludeDirs = { ".flatpak-builder" }
              },
            },
          }
        },
      })
    end

    -- Setup Julia language server
    if require("config.utils").known({ "julia" }) then
      lspconfig.julials.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "julia",
          "--project=@nvim-lspconfig",
          "-J" .. vim.fn.getenv("HOME") .. "/.julia/environments/nvim-lspconfig/languageserver.so",
          "--sysimage-native-code=yes",
          "--startup-file=no",
          "--history-file=no",
          "-e", [[
          import Pkg;
          function recurse_project_paths(path::AbstractString)
              isnothing(Base.current_project(path)) && return
              tmp = path
              CUSTOM_LOAD_PATH = []
              while !isnothing(Base.current_project(tmp))
                              pushfirst!(CUSTOM_LOAD_PATH, tmp)
                              tmp = dirname(tmp)
              end
              # push all to LOAD_PATHs
              pushfirst!(Base.LOAD_PATH, CUSTOM_LOAD_PATH...)
              return joinpath(CUSTOM_LOAD_PATH[1], "Project.toml")
          end
          buffer_file_path = "]] .. vim.fn.expand("%:p:h") .. '";' .. [[
          project_path = let
          dirname(something(
              # 1. Check if there is an explicitly set project
              # 2. Check for Project.toml in current working directory
              # 3. Check for Project.toml from buffer's full file path exluding the file name
              # 4. Fallback to global environment
              Base.load_path_expand((
                    p = get(ENV, "JULIA_PROJECT", nothing);
                    p === nothing ? nothing : isempty(p) ? nothing : p
              )),
              Base.current_project(strip(buffer_file_path)),
              Base.current_project(pwd()),
              Pkg.Types.Context().env.project_file,
              Base.active_project()
          ))
          end
          ls_install_path = joinpath(get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments", "nvim-lspconfig");
          pushfirst!(LOAD_PATH, ls_install_path);
          using LanguageServer;
          popfirst!(LOAD_PATH);
          @info "LOAD_PATHS: $(Base.load_path())"
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "");
          symbol_server_path = joinpath(homedir(), ".cache", "nvim", "julia_lsp_symbol_store")
          mkpath(symbol_server_path)
          @info "LanguageServer has started with buffer $project_path or $(pwd())"
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path, nothing, symbol_server_path, true);
          server.runlinter = true;
          run(server); ]]
        }
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
          }
        }
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
            }
          }
        }
      })
    end

    -- Setup autocommands
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    -- Format the code before writing
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.jl",
        "*.lua",
        "*.rs",
        "*.tex",
      },
      group = group,
      callback = function()
        vim.lsp.buf.formatting_seq_sync(nil, 2000)
      end,
    })
  end,
})
