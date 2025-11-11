-- ~/.config/nvim/lua/plugins/debugging.lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    -- ⬇️ Не указываем opts — LazyVim сам всё настроит
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = {
        "python",
        "netcoredbg", -- для C#
        "codelldb", -- для C/C++ (на основе LLDB)
        "rustc", -- для Rust (на самом деле использует codelldb + rustc)
      },
      automatic_installation = true,
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- Указываем путь к python как строку (не функцию!)
      local python_path = function()
        local cwd = vim.fn.getcwd()
        local venv = vim.fn.finddir(".venv", cwd .. ";")
        if venv ~= "" then
          return vim.fn.fnamemodify(venv, ":p") .. "bin/python"
        end
        return "python3"
      end

      -- Проверяем, установлен ли debugpy
      local ok = pcall(vim.fn.system, { python_path(), "-c", "import debugpy" })
      if not ok then
        vim.notify("Installing debugpy...", vim.log.levels.INFO)
        vim.fn.system({ python_path(), "-m", "pip", "install", "debugpy" })
      end

      -- Передаём строку в setup
      require("dap-python").setup(python_path())
    end,
  },
}
