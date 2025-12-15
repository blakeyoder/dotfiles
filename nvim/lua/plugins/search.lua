-- Search and fuzzy finding

return {
  -- FZF (keeping your existing setup)
  {
    "junegunn/fzf",
    lazy = false,
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    lazy = false,
    dependencies = { "junegunn/fzf" },
    config = function()
      -- Your existing Find command with ripgrep
      vim.cmd([[
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!ios/Pods/*" --glob "!android/.gradle/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
      ]])

      -- Keymaps (same as your .vimrc)
      vim.keymap.set("n", "<C-f>", ":Find<CR>", { silent = true, desc = "Find in files" })
      vim.keymap.set("n", "<C-p>", ":GFiles<CR>", { silent = true, desc = "Find git files" })
    end,
  },
}
