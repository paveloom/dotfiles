-- Neovim plugin to manage the file system and other tree like structures
require("packer").use {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  requires = {
    "MunifTanjim/nui.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    {
      -- This plugins prompts the user to pick a window
      -- and returns the window id of the picked window
      "s1n7ax/nvim-window-picker",
      tag = "v1.*",
      config = function()
        require "window-picker".setup({
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- Filter using buffer options
            bo = {
              -- If the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
              -- If the buffer type is one of following, the window will be ignored
              buftype = { "terminal" },
            },
          },
        })
      end,
    },
  },
  config = function()
    local neotree = require("neo-tree")
    -- Remove the deprecated commands from v1.x
    vim.g.neo_tree_remove_legacy_commands = 1
    -- Setup the plugin
    neotree.setup({
      use_default_mappings = false,
      close_if_last_window = true,
      default_component_configs = {
        modified = {
          symbol = "● ",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            -- Auto close
            neotree.close_all()
          end
        },
      },
      window = {
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = true,
          },
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["s"] = "split_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
          ["w"] = "open_with_window_picker",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "relative"
            }
          },
          ["A"] = {
            "add_directory",
            config = {
              show_path = "relative"
            }
          },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = {
            "copy",
            config = {
              show_path = "relative"
            }
          },
          ["m"] = {
            "move",
            config = {
              show_path = "relative"
            }
          },
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        }
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
        },
        follow_current_file = true,
        group_empty_dirs = false,
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
          }
        }
      },
      buffers = {
        follow_current_file = true,
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
          }
        },
      },
      git_status = {
        window = {
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          }
        }
      }
    })
    -- Map a keybinding in the normal mode
    local function nmap(k, e)
      vim.keymap.set("n", k, e, { silent = true })
    end

    -- Setup keybindings
    nmap("t", function()
      require("neo-tree.command").execute({ toggle = true, reveal = true })
    end)
  end,
}
