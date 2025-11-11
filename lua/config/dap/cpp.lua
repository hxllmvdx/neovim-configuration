-- ~/.config/nvim/lua/config/dap/cpp.lua
local dap = require("dap")
local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch with args",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", "./app", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    -- Передача аргументов:
    args = function()
      local input = vim.fn.input("Arguments (space-separated): ", "")
      return vim.fn.split(input, " ")
    end,
    runInTerminal = true,
  },
}

dap.configurations.rust = dap.configurations.cpp
