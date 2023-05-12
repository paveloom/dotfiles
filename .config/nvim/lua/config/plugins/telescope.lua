-- A highly extendable fuzzy finder over lists
return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    "folke/trouble.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local themes = require("telescope.themes")
    local trouble = require("trouble.providers.telescope")
    -- Set up the plugin
    telescope.setup({
      defaults = themes.get_ivy({
        mappings = {
          i = {
            ["<C-d>"] = false,
            ["<C-q>"] = trouble.open_with_trouble,
            ["<C-u>"] = false,
            ["<Esc>"] = "close",
            ["<PageDown>"] = "preview_scrolling_down",
            ["<PageUp>"] = "preview_scrolling_up",
          },
        },
      }),
      pickers = {
        find_files = {
          file_ignore_patterns = { "^.git/", "target/" },
          hidden = true,
        },
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = "delete_buffer",
            },
          },
        },
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        file_browser = {
          dir_icon = "",
          dir_icon_hl = "NeoTreeDirectoryIcon",
          display_stat = false,
          hijack_netrw = true,
          select_buffer = true,
          git_status = false,
          mappings = {
            ["i"] = {
              -- Trash files instead of deleting them
              ["<A-d>"] = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local call = require("config.utils").call
                local fb_utils = require("telescope._extensions.file_browser.utils")
                -- Get the finder
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local finder = current_picker.finder
                -- Get the selections
                local selections = fb_utils.get_selected_files(prompt_bufnr, false)
                if vim.tbl_isempty(selections) then
                  fb_utils.notify("actions.trash", {
                    msg = "No selection to be trashed!",
                    level = "WARN",
                    quiet = finder.quiet,
                  })
                  return
                end
                -- Trash the selected files
                local trashed = {}
                for _, selection in ipairs(selections) do
                  local filename = selection.filename:sub(#selection:parent().filename + 2)
                  -- `trash-put` is from the `trash-cli` package
                  if call({ "trash-put", "--", selection:absolute() }) then
                    table.insert(trashed, filename)
                  end
                end
                -- Notify about operations
                local message = ""
                if not vim.tbl_isempty(trashed) then
                  message = message .. "Trashed: " .. table.concat(trashed, ", ")
                end
                fb_utils.notify("actions.trash", { msg = message, level = "INFO", quiet = finder.quiet })
                -- Reset multi selection
                current_picker:refresh(current_picker.finder, { reset_prompt = true })
              end,
            },
          },
        },
        project = {
          hidden_files = true,
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("project")
  end,
  init = function()
    local nmap = require("config.utils").nmap

    -- Set up keybindings
    nmap("<leader>b", function()
      require("telescope.builtin").buffers()
    end)
    nmap("<leader>f", function()
      require("telescope.builtin").find_files()
    end)
    nmap("<leader>g", function()
      require("telescope.builtin").live_grep()
    end)
    nmap("<leader>h", function()
      require("telescope.builtin").help_tags()
    end)
    nmap("<leader>o", function()
      require("telescope.builtin").oldfiles()
    end)
    nmap("<leader>n", function()
      require("telescope").extensions.file_browser.file_browser()
    end)
    nmap("<leader>p", function()
      require("telescope").extensions.project.project({ display_type = "full" })
    end)
    nmap("z=", function()
      require("telescope.builtin").spell_suggest()
    end)
  end,
}
