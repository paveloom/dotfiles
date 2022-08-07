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
