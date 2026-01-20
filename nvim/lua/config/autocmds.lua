-- Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- React Native / Expo file types
augroup("ReactNative", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ReactNative",
  pattern = "*.tsx",
  callback = function()
    vim.bo.filetype = "typescriptreact"
  end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ReactNative",
  pattern = "*.jsx",
  callback = function()
    vim.bo.filetype = "javascriptreact"
  end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ReactNative",
  pattern = { "app.json", "eas.json", "app.config.js" },
  callback = function()
    vim.bo.filetype = "json"
  end,
})

-- Python config
augroup("PythonConfig", { clear = true })
autocmd("FileType", {
  group = "PythonConfig",
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "500"
  end,
})

-- JSON config
augroup("JSONConfig", { clear = true })
autocmd("FileType", {
  group = "JSONConfig",
  pattern = "json",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldlevel = 99
  end,
})

-- Markdown config
augroup("MarkdownConfig", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "MarkdownConfig",
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})
autocmd("FileType", {
  group = "MarkdownConfig",
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { buffer = true, desc = "Markdown preview" })
    vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { buffer = true, desc = "Stop markdown preview" })
  end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-reload files changed outside of Neovim
augroup("AutoRead", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = "AutoRead",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Open Telescope when opening a directory (git_files if git repo, else find_files)
augroup("DirectoryOpen", { clear = true })
autocmd("VimEnter", {
  group = "DirectoryOpen",
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      vim.schedule(function()
        local builtin = require("telescope.builtin")
        -- Use git_files if in a git repo, otherwise find_files
        local ok = pcall(builtin.git_files, { show_untracked = true })
        if not ok then
          builtin.find_files()
        end
      end)
    end
  end,
})
