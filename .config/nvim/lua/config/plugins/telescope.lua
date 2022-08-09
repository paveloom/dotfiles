local utils = require("config.utils")

local packer = require("packer")

if utils.known({ "rg", "fd" }) then
  -- A highly extendable fuzzy finder over lists
  packer.use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "kyazdani42/nvim-web-devicons",
    },
    after = "lush.nvim",
    config = function()
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      local themes = require("telescope.themes")
      -- Setup the plugin
      telescope.setup({
        defaults = themes.get_ivy {
          mappings = {
            i = {
              ["<Esc>"] = "close",
            }
          },
        },
        pickers = {
          find_files = {
            file_ignore_patterns = { "^.git/", "target/" },
            hidden = true,
          },
          buffers = {
            mappings = {
              i = {
                ["<C-d>"] = "delete_buffer",
              }
            }
          }
        },
        extensions = {
          file_browser = {
            dir_icon = "",
            display_stat = false,
            hijack_netrw = true,
            select_buffer = true,
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
                    fb_utils.notify("actions.trash",
                      { msg = "No selection to be trashed!", level = "WARN", quiet = finder.quiet })
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
              }
            }
          },
          project = {
            hidden_files = true,
          }
        }
      })
      -- Map a keybinding in the normal mode
      local function nmap(k, e)
        vim.keymap.set("n", k, e, { silent = true })
      end

      -- Setup keybindings
      nmap("<leader>b", builtin.buffers)
      nmap("<leader>f", builtin.find_files)
      nmap("<leader>g", builtin.live_grep)
      nmap("<leader>h", builtin.help_tags)
      nmap("<leader>o", builtin.oldfiles)
    end,
  })

  -- File Browser extension for Telescope
  packer.use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    after = "telescope.nvim",
    config = function()
      local telescope = require("telescope")
      -- Load the extension
      telescope.load_extension("file_browser")
      -- Map a keybinding in the normal mode
      local function nmap(k, e)
        vim.keymap.set("n", k, e, { silent = true })
      end

      -- Setup keybindings
      nmap("<leader>n", function()
        telescope.extensions.file_browser.file_browser()
      end)
    end,
  })

  -- An extension for Telescope that allows you to switch between projects
  packer.use({
    "nvim-telescope/telescope-project.nvim",
    requires = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope.nvim",
    },
    after = "telescope-file-browser.nvim",
    config = function()
      local telescope = require("telescope")
      -- Load the extension
      telescope.load_extension("project")
      -- Map a keybinding in the normal mode
      local function nmap(k, e)
        vim.keymap.set("n", k, e, { silent = true })
      end

      -- Setup keybindings
      nmap("<leader>p", function()
        telescope.extensions.project.project({ display_type = "full" })
      end)
    end,
  })

  if utils.known({ "make" }) then
    -- FZF sorter for Telescope written in C
    packer.use({
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      after = "telescope-project.nvim",
      run = "make",
      config = function()
        -- Load the extension
        require("telescope").load_extension("fzf")
      end,
    })
  end
end
