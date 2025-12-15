--  ██████╗ ██╗      █████╗ ██╗  ██╗███████╗███████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
--  ██╔══██╗██║     ██╔══██╗██║ ██╔╝██╔════╝██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║
--  ██████╔╝██║     ███████║█████╔╝ █████╗  ███████╗    ██╔██╗ ██║██║   ██║██║██╔████╔██║
--  ██╔══██╗██║     ██╔══██║██╔═██╗ ██╔══╝  ╚════██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
--  ██████╔╝███████╗██║  ██║██║  ██╗███████╗███████║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
--  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Blake's Neovim Configuration

-- Set leader key early (before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

-- Set colorscheme after plugins load
vim.cmd.colorscheme("gruvbox")
