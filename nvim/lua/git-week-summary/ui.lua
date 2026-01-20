local M = {}

-- Track current window state
local state = {
  buf = nil,
  win = nil,
  timer = nil,
  status = "",
  logs = {},
}

-- Animation frames for loading dots
local loading_frames = { ".  ", ".. ", "...", " ..", "  .", "   " }

--- Calculate window dimensions
---@return table { width, height, row, col }
local function calc_dimensions()
  local width = math.min(100, math.floor(vim.o.columns * 0.8))
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  return {
    width = width,
    height = height,
    row = row,
    col = col,
  }
end

--- Stop the loading animation timer
local function stop_timer()
  if state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end
end

--- Render the current state to buffer
local function render()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end

  local lines = { "" }

  -- Add completed log entries
  for _, log in ipairs(state.logs) do
    table.insert(lines, "  " .. log)
  end

  -- Add current status with placeholder for dots
  if state.status ~= "" then
    table.insert(lines, "  " .. state.status .. "...")
  end

  table.insert(lines, "")

  vim.api.nvim_buf_set_option(state.buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(state.buf, "modifiable", false)
end

--- Start the dot animation
local function start_animation()
  stop_timer()

  local frame_idx = 1
  state.timer = vim.loop.new_timer()
  state.timer:start(
    0,
    150,
    vim.schedule_wrap(function()
      if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
        stop_timer()
        return
      end

      if state.status == "" then
        return
      end

      local dots = loading_frames[frame_idx]
      frame_idx = (frame_idx % #loading_frames) + 1

      -- Update only the status line (last non-empty content line)
      local status_line = #state.logs + 1 -- 0-indexed: line after logs + empty first line

      vim.api.nvim_buf_set_option(state.buf, "modifiable", true)
      vim.api.nvim_buf_set_lines(state.buf, status_line, status_line + 1, false, {
        "  " .. state.status .. dots,
      })
      vim.api.nvim_buf_set_option(state.buf, "modifiable", false)
    end)
  )
end

--- Close the floating window
function M.close()
  stop_timer()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    vim.api.nvim_buf_delete(state.buf, { force = true })
  end
  state.win = nil
  state.buf = nil
  state.status = ""
  state.logs = {}
end

--- Create and open a floating window
---@param content string[] Lines to display
---@return number buf, number win
function M.open(content)
  -- Close existing window if open
  M.close()

  local dim = calc_dimensions()

  -- Create buffer
  state.buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer content
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, content)

  -- Buffer options
  vim.api.nvim_buf_set_option(state.buf, "modifiable", false)
  vim.api.nvim_buf_set_option(state.buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(state.buf, "filetype", "markdown")

  -- Create window
  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = dim.width,
    height = dim.height,
    row = dim.row,
    col = dim.col,
    style = "minimal",
    border = "rounded",
    title = " Git Week Summary ",
    title_pos = "center",
  })

  -- Window options
  vim.api.nvim_win_set_option(state.win, "wrap", true)
  vim.api.nvim_win_set_option(state.win, "cursorline", true)

  -- Keymaps to close
  local opts = { buffer = state.buf, noremap = true, silent = true }
  vim.keymap.set("n", "q", M.close, opts)
  vim.keymap.set("n", "<Esc>", M.close, opts)

  return state.buf, state.win
end

--- Update content in existing window
---@param content string[] New lines to display
function M.update(content)
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end

  vim.api.nvim_buf_set_option(state.buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, content)
  vim.api.nvim_buf_set_option(state.buf, "modifiable", false)
end

--- Start the loading UI
---@param status string Initial status message (without dots)
function M.start_loading(status)
  state.logs = {}
  state.status = status

  M.open({ "", "  " .. status .. "...", "" })
  start_animation()
end

--- Update the status message (moves previous status to log)
---@param status string New status message (without dots)
function M.set_status(status)
  -- Move current status to logs as completed
  if state.status ~= "" then
    table.insert(state.logs, state.status .. "... done")
  end

  state.status = status
  render()
end

--- Show error message
---@param message string
function M.show_error(message)
  stop_timer()

  local lines = { "" }

  -- Show completed logs
  for _, log in ipairs(state.logs) do
    table.insert(lines, "  " .. log)
  end

  -- Show failed status
  if state.status ~= "" then
    table.insert(lines, "  " .. state.status .. "... failed")
  end

  table.insert(lines, "")
  table.insert(lines, "  Error")
  table.insert(lines, "  " .. string.rep("-", 40))

  for line in message:gmatch("[^\n]+") do
    table.insert(lines, "  " .. line)
  end

  table.insert(lines, "")
  table.insert(lines, "  Press q or <Esc> to close")

  M.update(lines)
end

--- Show summary
---@param summary string
function M.show_summary(summary)
  stop_timer()

  local lines = { "" }

  -- Show completed logs
  for _, log in ipairs(state.logs) do
    table.insert(lines, "  " .. log)
  end

  -- Mark current status as done
  if state.status ~= "" then
    table.insert(lines, "  " .. state.status .. "... done")
  end

  table.insert(lines, "")
  table.insert(lines, "  " .. string.rep("-", 40))
  table.insert(lines, "")

  for line in summary:gmatch("[^\n]*") do
    table.insert(lines, "  " .. line)
  end

  table.insert(lines, "")
  table.insert(lines, "  " .. string.rep("-", 40))
  table.insert(lines, "  Press q or <Esc> to close")

  M.update(lines)
end

return M
