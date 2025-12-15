-- LSP configuration for TypeScript, React, GraphQL, etc.
-- Uses Neovim 0.11+ native vim.lsp.config API

return {
  -- Mason - auto-install LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "graphql",
          "jsonls",
          "html",
          "cssls",
          "pyright",
          "rust_analyzer",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP config (needed for mason-lspconfig to work)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Capabilities for completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Shared on_attach function for keymaps
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "K", vim.lsp.buf.hover, "Show documentation")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

        -- Actions
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")

        -- Diagnostics
        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic")
      end

      -- Configure LSP servers using vim.lsp.config (0.11+ API)
      local servers = {
        ts_ls = {},
        eslint = {},
        graphql = {
          filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript", "javascript" },
        },
        jsonls = {},
        html = {},
        cssls = {},
        pyright = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
      }

      -- Set up each server
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        if not config.on_attach then
          config.on_attach = on_attach
        end
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      -- Diagnostic signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.HINT] = "➤",
            [vim.diagnostic.severity.INFO] = "ℹ",
          },
        },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
      })
    end,
  },

  -- Formatter (for Prettier, etc.)
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
