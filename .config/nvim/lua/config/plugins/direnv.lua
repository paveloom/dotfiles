-- Vim plugin for `direnv` support
return {
  "direnv/direnv.vim",
  config = function()
    vim.g.direnv_silent_load = 1
  end,
}
