local M = {}

local fn = vim.fn
local o = vim.opt

-- Map a keybinding
local function map(m, k, e)
  vim.keymap.set(m, k, e, { silent = true })
end

-- Map a keybinding in the command mode
function M.cmap(k, e)
  map("c", k, e)
end

-- Map a keybinding in the insert mode
function M.imap(k, e)
  map("i", k, e)
end

-- Map a keybinding in the normal mode
function M.nmap(k, e)
  map("n", k, e)
end

-- Map a keybinding in the visual mode
function M.vmap(k, e)
  map("v", k, e)
end

-- Map a keybinding in the visual and select modes
function M.xmap(k, e)
  map("x", k, e)
end

-- Do a system call and check the status code
function M.call(cmd)
  fn.system(cmd)
  return vim.v.shell_error == 0
end

-- Check if the commands are known
function M.known(cmds)
  -- Check each command
  for _, cmd in pairs(cmds) do
    -- If the command doesn't exist
    if not M.call({ "command", "-v", cmd }) then
      -- Notify about that
      vim.notify("Unknown command: `" .. cmd .. "`.", vim.log.levels.WARN, nil)
      return false
    else
      return true
    end
  end
end

-- Add the specified language
function M.add_lang(id)
  -- If `curl` is not present, return
  if not M.known({ "curl" }) then
    return
  end
  -- Define the server URL
  local url = "http://ftp.vim.org/pub/vim/runtime/spell/"
  -- Define the path to the directory with the spell files
  local spell_path = fn.stdpath("data") .. "/site/spell/"
  -- Make sure this directory exists
  fn.system({ "mkdir", "-p", spell_path })
  -- Download the spell file with the specified extension
  local function download(ext)
    -- Define the name of the file
    local file_name = id .. ".utf-8." .. ext
    -- Define the path to the file
    local file_path = spell_path .. file_name
    -- If the file is not readable
    if fn.filereadable(file_path) == 0 then
      -- Define the link to the file
      local file_link = url .. file_name
      -- Try to download the file
      print("Downloading `" .. file_name .. "`...")
      if not M.call({ "curl", "-sLo", file_path, file_link }) then
        print("Couldn't download " .. file_name)
        return false
      end
    end
    return true
  end

  -- Download the spell files
  if download("spl") and download("sug") then
    o.spelllang:append(id)
  end
end

return M
