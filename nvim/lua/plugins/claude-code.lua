-- Claude Code integration
-- Toggle Claude Code CLI in a terminal with <C-,>

return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        -- Command to run (with skip permissions)
        command = "claude --dangerously-skip-permissions",
        -- Window settings
        window = {
          position = "botright",  -- or "float" for floating window
          split_ratio = 0.3,      -- 30% of screen height
        },
        -- Auto-refresh files when Claude modifies them
        refresh = {
          enable = true,
          updatetime = 100,       -- Check every 100ms
          show_notifications = true,
        },
        -- Auto-detect git root
        git = {
          use_git_root = true,
        },
        -- Custom keymaps
        keymaps = {
          toggle = {
            normal = "<leader>cc",
            terminal = "<leader>cc",
          },
        },
      })
    end,
    keys = {
      { "<leader>cc", desc = "Toggle Claude Code" },
    },
  },
}
