local fn = vim.fn
local o = vim.opt

-- Prepare paths
local packer_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/plugin/compiled.lua"

-- If `packer` is not installed
local packer_bootstrapped = false
if fn.isdirectory(packer_path) == 0 then
  -- If `git` exists on the system
  if fn.system({ "git", "-v" }) then
    -- Try to clone the repository
    print("Cloning the `packer` repository...")
    if fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      packer_path
    }) then
      -- Add the package path to the runtime path
      o.runtimepath:prepend(packer_path)
      -- If there is a compiled lazy-loader code
      if fn.filereadable(compile_path) == 1 then
        -- Delete it
        fn.system({ "rm", compile_path })
      end
      packer_bootstrapped = true
      -- Otherwise,
    else
      print("Couldn't clone the repository.")
    end
    -- Otherwise,
  else
    print("Git is not installed.")
  end
end

-- Initialize `packer` manually
local packer = require("packer")
packer.init({
  compile_path = compile_path,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end
  }
})
packer.reset()

-- Setup `impatient`
require("config.plugins.impatient")

-- Setup plugins
packer.use("wbthomason/packer.nvim")
require("config.plugins.bufjump")
require("config.plugins.bufresize")
require("config.plugins.comment")
require("config.plugins.crates")
require("config.plugins.dressing")
require("config.plugins.feline")
require("config.plugins.fidget")
require("config.plugins.glow")
require("config.plugins.harpoon")
require("config.plugins.indent-o-matic")
require("config.plugins.lsp_lines")
require("config.plugins.lush")
require("config.plugins.neo-tree")
require("config.plugins.null-ls")
require("config.plugins.nvim-cmp")
require("config.plugins.nvim-lspconfig")
require("config.plugins.nvim-notify")
require("config.plugins.nvim-rooter")
require("config.plugins.nvim-surround")
require("config.plugins.nvim-treesitter")
require("config.plugins.sessions")
require("config.plugins.spellsitter")
require("config.plugins.telescope")
require("config.plugins.tidy")
require("config.plugins.vgit")

-- Do a sync after bootstrapping `packer`
if packer_bootstrapped then
  packer.sync()
end
