-- Trouble: Pretty diagnostics list
-- Better than :lopen, shows all errors/warnings in a nice UI

return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Use new Trouble v3 config
      modes = {
        diagnostics = {
          auto_close = false,
          auto_open = false,
          auto_preview = true,
          auto_refresh = true,
          focus = true,
          follow = true,
        },
      },
    },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Defs/Refs (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
}
