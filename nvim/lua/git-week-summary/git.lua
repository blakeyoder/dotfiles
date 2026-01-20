local M = {}

--- Check if current directory is a git repository
---@return boolean
function M.is_git_repo()
  local result = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  return vim.v.shell_error == 0 and result:match("true") ~= nil
end

--- Get commits from the last week
---@param callback fun(commits: string|nil, error: string|nil)
function M.get_week_commits(callback)
  if not M.is_git_repo() then
    callback(nil, "Not a git repository")
    return
  end

  local cmd = {
    "git",
    "log",
    "--since=1 week ago",
    "--pretty=format:%h %s (%an, %ar)",
    "--no-merges",
  }

  local output = {}
  local stderr = {}

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(stderr, line)
          end
        end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        callback(nil, table.concat(stderr, "\n"))
        return
      end

      if #output == 0 then
        callback(nil, "No commits found in the last week")
        return
      end

      callback(table.concat(output, "\n"), nil)
    end,
  })
end

return M
