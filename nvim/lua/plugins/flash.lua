-- Flash: Modern motion plugin
-- Jump anywhere on screen in 2-3 keystrokes

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- Labels appear on matches for quick jumping
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        -- Search also matches beginning of words
        mode = "fuzzy",
      },
      jump = {
        -- Automatically jump when there is only one match
        autojump = true,
      },
      label = {
        -- Show labels after the match
        after = true,
        before = false,
        style = "overlay",
      },
      modes = {
        -- `s` for flash search
        char = {
          enabled = true,
          -- Enhance f, t, F, T motions
          keys = { "f", "F", "t", "T", ";", "," },
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
