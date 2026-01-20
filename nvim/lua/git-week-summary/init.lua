local git = require("git-week-summary.git")
local ai = require("git-week-summary.ai")
local ui = require("git-week-summary.ui")

local M = {}

--- Run the week summary workflow
function M.summarize()
  -- Start with fetching commits
  ui.start_loading("Fetching commits")

  -- Fetch commits
  git.get_week_commits(function(commits, err)
    if err then
      vim.schedule(function()
        ui.show_error(err)
      end)
      return
    end

    -- Update status to analyzing
    vim.schedule(function()
      ui.set_status("Analyzing commits with Claude")
    end)

    -- Generate AI summary
    ai.summarize(commits, function(summary, ai_err)
      vim.schedule(function()
        if ai_err then
          ui.show_error("Failed to generate summary:\n" .. ai_err)
          return
        end

        ui.show_summary(summary)
      end)
    end)
  end)
end

--- Setup function (optional configuration)
---@param opts table|nil Optional configuration
function M.setup(opts)
  opts = opts or {}

  -- Register user command
  vim.api.nvim_create_user_command("GitWeekSummary", function()
    M.summarize()
  end, {
    desc = "Summarize git commits from the last week using AI",
  })
end

return M
