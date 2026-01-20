local M = {}

local DEFAULT_PROMPT = [[
Summarize these git commits from the last week. Group by theme/area if applicable,
highlight key changes, and note any patterns. Be concise but informative.

<commits>
%s
</commits>
]]

--- Generate AI summary of commits using Claude CLI
---@param commits string The commit log to summarize
---@param callback fun(summary: string|nil, error: string|nil)
function M.summarize(commits, callback)
  local prompt = string.format(DEFAULT_PROMPT, commits)

  local output = {}
  local stderr = {}

  local job_id = vim.fn.jobstart({ "claude", "--print" }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          table.insert(output, line)
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
        local err_msg = #stderr > 0 and table.concat(stderr, "\n") or "Claude CLI failed"
        callback(nil, err_msg)
        return
      end

      -- Filter empty lines from end
      while #output > 0 and output[#output] == "" do
        table.remove(output)
      end

      if #output == 0 then
        callback(nil, "Claude returned empty response")
        return
      end

      callback(table.concat(output, "\n"), nil)
    end,
  })

  -- Send prompt via stdin and close it
  if job_id > 0 then
    vim.fn.chansend(job_id, prompt)
    vim.fn.chanclose(job_id, "stdin")
  else
    callback(nil, "Failed to start Claude CLI")
  end
end

return M
