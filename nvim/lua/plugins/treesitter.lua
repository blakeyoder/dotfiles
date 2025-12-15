-- Treesitter for better syntax highlighting and code understanding

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- nvim-treesitter 1.0+ with Neovim 0.11+
      -- Enable treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- To install parsers manually, run:
      -- :TSInstall tsx typescript javascript html css json lua python rust bash
    end,
  },

  -- mini.ai: Better textobjects (replaces nvim-treesitter-textobjects)
  -- Works with native treesitter, no compatibility issues
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          -- Function textobject (treesitter-based)
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          -- Class textobject
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          -- Loop textobject
          l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          -- Conditional textobject
          o = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
          -- Parameter/argument textobject
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
          -- Comment textobject
          ["/"] = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
        },
      })
    end,
  },

  -- mini.move: Move lines and selections
  {
    "echasnovski/mini.move",
    version = "*",
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },

  -- Treesitter context - shows current function/class at top of screen
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
      })
    end,
  },
}
