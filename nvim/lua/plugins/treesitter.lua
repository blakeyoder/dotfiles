-- Treesitter for better syntax highlighting and code understanding

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Neovim 0.11+ uses vim.treesitter directly
      local configs = require("nvim-treesitter.install")

      -- Ensure these parsers are installed
      local ensure_installed = {
        "typescript", "tsx", "javascript", "html", "css", "json", "graphql",
        "yaml", "toml", "markdown", "markdown_inline",
        "python", "rust", "lua", "vim", "vimdoc",
        "bash", "regex", "gitignore", "diff",
      }

      -- Install parsers
      for _, parser in ipairs(ensure_installed) do
        pcall(function()
          configs.ensure_installed(parser)
        end)
      end

      -- Enable highlighting via vim.treesitter (0.11+ native)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
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
