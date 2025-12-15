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
    vim.cmd("normal zR")
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
