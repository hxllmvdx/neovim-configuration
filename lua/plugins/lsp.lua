-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  -- 1. Mason: установка LSP-серверов и инструментов
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",
        -- C/C++ (с поддержкой C++20)
        "clangd",
        -- C#
        "omnisharp",
        -- Rust
        "rust-analyzer",
        -- Форматтеры и линтеры
        "ruff", -- Python
        "stylua", -- Lua
        "prettier", -- JS/TS/JSON
        "clang-format", -- C/C++ форматирование
      },
    },
  },

  -- 2. Mason-LSPConfig: интеграция с LSPConfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
  },

  -- 3. Nvim-LSPConfig: основная настройка LSP БЕЗ CMP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Настройка clangd для C++20 (concepts)
      lspconfig.clangd.setup({
        cmd = {
          "/opt/homebrew/opt/llvm/bin/clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--query-driver=/usr/bin/*,/opt/homebrew/opt/llvm/bin/*", -- ← Маска для ВСЕХ компиляторов
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })

      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true, -- Авто-поиск venv
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Остальные LSP-серверы (автоматическая настройка)
      local servers = { "pyright", "rust_analyzer", "omnisharp" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end

      -- 4. Создаём команду :LspInfo без привязки к cmp
      vim.api.nvim_create_user_command("LspInfo", function()
        local clients = vim.lsp.get_active_clients()
        if #clients == 0 then
          print("No active LSP clients")
          return
        end

        print("Active LSP clients:")
        for _, client in ipairs(clients) do
          local root = client.config.root_dir or "no root"
          local name = client.name
          print(string.format("  • %-12s root: %s", name, root))
        end
      end, {})
    end,
  },
}
