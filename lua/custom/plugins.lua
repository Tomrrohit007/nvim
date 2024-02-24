local plugins = {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "html", "cssls", "clangd", "tsserver", "tailwindcss", "prismals", "eslint", "json" },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      local config = require "nvim-treesitter.configs"
      config.setup {
        ensure_installed = "maintained",
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-tmux",
      "quangnguyen30192/cmp-nvim-ultisnips", -- UltiSnips source
      "L3MON4D3/LuaSnip", -- LuaSnip source
      "hrsh7th/cmp-jump", -- Jump source for local symbols
      "hrsh7th/cmp-look", -- Look source for fuzzy matching
    },
    config = function()
      local cmp = require "cmp"
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Tab>"] = cmp.mapping.confirm { select = true },
          ["<CR>"] = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "calc" },
          { name = "vsnip" },
          { name = "emoji" },
          { name = "omni" },
          { name = "tmux" },
          { name = "ultisnips" },
          { name = "luasnip" },
          { name = "jump" }, -- Source for local symbols
          { name = "look" }, -- Source for fuzzy matching
        },
      }

      -- Extend file types for luasnip snippets in JavaScript React and TypeScript React to include HTML
      require("luasnip").filetype_extend("javascriptreact", { "html" })
      require("luasnip").filetype_extend("typescriptreact", { "html" })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufFilePre" }, -- Listen for save events
    config = function()
      local conform = require "conform"
      conform.setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 200,
        },
      }
      -- Trigger formatting on save
      vim.api.nvim_command "autocmd BufWritePre * lua require('conform').format()"
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 300,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local filetypes = {
        "javascript",
        "javascriptreact",
        "svelte",
        "typescript",
        "typescriptreact",
      }

      local linter = { "eslint" }
      local ft_configs = {}

      for _, value in pairs(filetypes) do
        ft_configs[value] = linter
      end

      require("lint").linters_by_ft = ft_configs

      vim.api.nvim_command "autocmd BufWritePost,BufEnter * lua require('lint').try_lint()"
    end,
  },

  {
    "echasnovski/mini.animate",
    version = "*",
    config = function()
      require("mini.animate").setup {}
    end,
    event = "VeryLazy",
  },
}

return plugins
