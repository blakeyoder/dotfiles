-- Plugin specifications for lazy.nvim

return {
  -- Colorscheme (load first)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
      })
    end,
  },
}
