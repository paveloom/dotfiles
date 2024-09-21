-- A simple session manager plugin
return {
  "natecraddock/sessions.nvim",
  config = function()
    local name = "sessions"
    local sessions = require(name)
    -- Set up the plugin
    sessions.setup({
      absolute = true,
      events = { "BufDelete", "BufEnter" },
      session_filepath = vim.fn.stdpath("data") .. "/sessions",
    })
    -- Set up autocommands
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    -- Save the session before leaving Vim
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      nested = true,
      callback = function()
        -- Close the tree
        require("neo-tree").close_all()
        -- Close all floating windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
          end
        end
        -- Save the session
        sessions.save(nil, { autosave = false, silent = true })
      end,
    })
  end,
}
