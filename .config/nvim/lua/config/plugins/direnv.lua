-- Vim plugin for `direnv` support
return {
  "direnv/direnv.vim",
  config = function()
    vim.g.direnv_silent_load = 1
    -- Start LSP clients when a Direnv environment is loaded for the first time
    local group = vim.api.nvim_create_augroup("direnv", { clear = false })
    vim.api.nvim_create_autocmd("User", {
      pattern = "DirenvLoaded",
      group = group,
      callback = function()
        if vim.b.direnv_loaded == nil then
          local buffer_filetype = vim.bo.filetype
          for _, config in pairs(require("lspconfig.configs")) do
            for _, filetype_match in ipairs(config.filetypes or {}) do
              if buffer_filetype == filetype_match then
                -- Launch the server if the executable exists
                if vim.fn.executable(config.cmd[1]) ~= 0 then
                  config.launch()
                end
              end
            end
          end
          vim.b.direnv_loaded = true
        end
      end,
    })
  end,
}
