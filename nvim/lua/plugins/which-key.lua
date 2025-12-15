-- Which-key: shows available keybindings in a popup

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        delay = 300, -- show after 300ms pause
      })

      -- Document key groups
      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>e", group = "Edit project files" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>s", group = "Source/Search" },
        { "<leader>m", group = "Markdown" },
      })
    end,
  },
}
