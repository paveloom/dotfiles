-- A simple session manager plugin
require("packer").use({
  "natecraddock/sessions.nvim",
  config = function()
    local name = "sessions"
    local sessions = require(name)
    -- Setup the plugin
    sessions.setup({
      events = { "BufEnter" },
      session_filepath = vim.fn.stdpath("data") .. "/session.vim",
    })
    -- Setup autocommands
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    -- Save the session before leaving Vim
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      nested = true,
      callback = function()
        -- Close the tree
        require("neo-tree.command").execute({ action = "close" })
        -- Save the session
        sessions.save(nil, { autosave = false, silent = true })
      end,
    })
    -- Restore the session when entering Vim
    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      nested = true,
      callback = function()
        -- Save the arguments (full paths expected)
        local args = vim.fn.argv()
        -- Try to restore the last session
        sessions.load(nil, { autosave = false, silent = true })
        -- Open the arguments
        for i = 1, #args do
          vim.cmd("edit " .. args[i])
        end
        -- Save the changes and start recording
        sessions.save()
      end,
    })
  end,
})
