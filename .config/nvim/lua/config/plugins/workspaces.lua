local mappings = require("config.mappings")

-- A simple plugin to manage workspace directories in NeoVim
return {
  "natecraddock/workspaces.nvim",
  config = function()
    require("workspaces").setup({
      hooks = {
        add = function()
          require("sessions").start_autosave()
        end,
        open_pre = function()
          require("sessions").stop_autosave({ save = true })

          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end,
        open = function()
          require("sessions").load(nil, { autosave = true, silent = true })
        end,
      },
    })
  end,
  init = function()
    mappings.map("n", "<leader>p", function()
      require("telescope").extensions.workspaces.workspaces()
    end)
  end,
}
