-- ~/.config/nvim/lua/config/dap/python.lua

local dap = require("dap")

-- Дебаг: выводим путь к python
local function get_python_path()
  local cwd = vim.fn.getcwd()
  local venv_path = vim.fn.finddir(".venv", cwd .. ";")
  if venv_path ~= "" then
    local path = vim.fn.fnamemodify(venv_path, ":p") .. "bin/python"
    print("Using Python from venv:", path)
    return path
  end
  print("Using system Python")
  return "python3"
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch in venv",
    program = "${file}",
    console = "integratedTerminal",
    justMyCode = true,
    args = function()
      local input = vim.fn.input("Arguments: ", "")
      return vim.fn.split(input, " ")
    end,
  },
}
