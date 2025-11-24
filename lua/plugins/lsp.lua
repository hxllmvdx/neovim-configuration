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
        -- CMake
        "neocmakelsp", -- LSP для CMake
        "cmakelang", -- форматтер для CMake
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
    "mason-org/mason.nvim",
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
      -- ~/.config/nvim/lua/plugins/lsp.lua
      lspconfig.clangd.setup({
        cmd = {
          "/opt/homebrew/opt/llvm/bin/clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--all-scopes-completion",
          "--pch-storage=memory",
          -- УБРАТЬ: "--cross-file-rename",  (устаревший флаг)
          "--compile-commands-dir=build",
          "--query-driver=/opt/homebrew/opt/llvm/bin/clang++",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = (function()
          local caps = vim.lsp.protocol.make_client_capabilities()
          -- Исправить предупреждение об offsetEncoding
          caps.offsetEncoding = { "utf-16" }
          return caps
        end)(),
        settings = {
          clangd = {
            fallbackFlags = {
              "-I/opt/homebrew/include",
              "-std=c++23",
            },
          },
        },
      })

      lspconfig.neocmake.setup({
        cmd = { "neocmakelsp", "stdio" }, -- Без аргумента --stdio
        filetypes = { "cmake" },
        root_dir = lspconfig.util.root_pattern("CMakeLists.txt", "build", ".git"),
        single_file_support = true,
      })

      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
            pythonPath = "./.venv/bin/python",
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
