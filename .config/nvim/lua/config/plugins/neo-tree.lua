local mappings = require("config.mappings")

-- Neovim plugin to manage the file system and other tree like structures
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      -- This plugins prompts the user to pick a window
      -- and returns the window id of the picked window
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup({
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- Filter using buffer options
            bo = {
              -- If the file type is one of following, the window will be ignored
              filetype = {
                "neo-tree",
                "neo-tree-popup",
                "notify",
                "quickfix",
              },
              -- If the buffer type is one of following, the window will be ignored
              buftype = { "terminal" },
            },
          },
        })
      end,
    },
  },
  config = function()
    local neo_tree = require("neo-tree")
    local inputs = require("neo-tree.ui.inputs")

    -- Trash the target
    local function trash(state)
      local node = state.tree:get_node()
      if node.type == "message" then
        return
      end
      local _, name = require("neo-tree.utils").split_path(node.path)
      local msg = string.format("Are you sure you want to trash '%s'?", name)
      inputs.confirm(msg, function(confirmed)
        if not confirmed then
          return
        end
        vim.api.nvim_command("silent !trash " .. node.path)
        require("neo-tree.sources.manager").refresh(state)
      end)
    end

    -- Trash the selections (visual mode)
    local function trash_visual(state, selected_nodes)
      local paths_to_trash = {}
      for _, node in ipairs(selected_nodes) do
        if node.type ~= "message" then
          table.insert(paths_to_trash, node.path)
        end
      end
      local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
      inputs.confirm(msg, function(confirmed)
        if not confirmed then
          return
        end
        for _, path in ipairs(paths_to_trash) do
          vim.api.nvim_command("silent !trash " .. path)
        end
        require("neo-tree.sources.manager").refresh(state)
      end)
    end

    neo_tree.setup({
      use_default_mappings = false,
      close_if_last_window = true,
      default_component_configs = {
        modified = {
          symbol = "●",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
        indent = {
          with_expanders = true,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            -- Auto close
            neo_tree.close_all()
          end,
        },
      },
      window = {
        mappings = {
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
              show_path = "relative",
            },
          },
          ["A"] = {
            "add_directory",
            config = {
              show_path = "relative",
            },
          },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = {
            "copy",
            config = {
              show_path = "relative",
            },
          },
          ["m"] = {
            "move",
            config = {
              show_path = "relative",
            },
          },
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      filesystem = {
        commands = {
          delete = trash,
          delete_visual = trash_visual,
        },
        components = {
          name = function(config, node, state)
            -- First call the default name component
            local cc = require("neo-tree.sources.common.components")
            local result = cc.name(config, node, state)
            -- If it is root, use only the last part of the path
            if node:get_depth() == 1 then
              result.text = vim.fn.fnamemodify(state.path, ":t")
            end
            return result
          end,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
        },
        follow_current_file = {
          enabled = true,
        },
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
          },
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
          },
        },
      },
      git_status = {
        window = {
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
    })
  end,
  init = function()
    mappings.map("n", "<leader>w", function()
      require("neo-tree.command").execute({ toggle = true, reveal = true })
    end)
  end,
}
