local M = {}

function _G.run(arg)
  f = io.popen(arg .. " 2>/dev/null")
  local out = f:read('*a')
  f:close()
  return out:sub(1, -2)
end

local function is_git_repo()
  return string.find(run("git rev-parse --git-dir"), "^.git") ~= nil
end

function _G.is_git_tracked(path)
  -- if not is_git_repo() then
  --     return false
  -- end
  return run("git ls-files --error-unmatch " .. path) ~= ""
end

function M.has_neovim_v05()
  if vim.fn.has('nvim-0.5') == 1 then
    return true
  end
  return false
end

function M.is_darwin()
  local os_name = vim.loop.os_uname().sysname
  return os_name == 'Darwin'
end


-- 'q': find the quickfix window
-- 'l': find all loclist windows
function M.find_qf(type)
  local wininfo = vim.fn.getwininfo()
  local win_tbl = {}
  for _, win in pairs(wininfo) do
    local found = false
    if type == 'l' and win['loclist'] == 1 then
      found = true
    end
    -- loclist window has 'quickfix' set, eliminate those
    if type == 'q' and win['quickfix'] == 1 and win['loclist'] == 0  then
      found = true
    end
    if found then
      table.insert(win_tbl, { winid = win['winid'], bufnr = win['bufnr'] })
    end
  end
  return win_tbl
end

-- open quickfix if not empty
function M.open_qf()
  local qf_name = 'quickfix'
  local qf_empty = function() return vim.tbl_isempty(vim.fn.getqflist()) end
  if not qf_empty() then
    vim.cmd('copen')
    vim.cmd('wincmd J')
  else
    print(string.format("%s is empty.", qf_name))
  end
end

-- enum all non-qf windows and open
-- loclist on all windows where not empty
function M.open_loclist_all()
  local wininfo = vim.fn.getwininfo()
  local qf_name = 'loclist'
  local qf_empty = function(winnr) return vim.tbl_isempty(vim.fn.getloclist(winnr)) end
  for _, win in pairs(wininfo) do
    if win['quickfix'] == 0 then
      if not qf_empty(win['winnr']) then
        -- switch active window before ':lopen'
        vim.api.nvim_set_current_win(win['winid'])
        vim.cmd('lopen')
      else
        print(string.format("%s is empty.", qf_name))
      end
    end
  end
end

-- Can also use #T ?
function M.tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function M.toggle_qf(type)
  local windows = M.find_qf(type)
  if M.tablelength(windows) > 0 then
    -- hide all visible windows
    for _, win in pairs(windows) do
      vim.api.nvim_win_hide(win.winid)
    end
  else
    -- no windows are visible, attempt to open
    if type == 'l' then
      M.open_loclist_all()
    else
      M.open_qf()
    end
  end
end

return M
